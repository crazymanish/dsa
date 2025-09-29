// Time Complexity: O(N³)
// The solution uses recursion with memoization. The state is defined by two indices (l, r),
// leading to O(N²) possible subproblems. Each subproblem involves a loop that iterates up to
// O(N) times. Thus, the total complexity is O(N²) * O(N) = O(N³).
//
// Space Complexity: O(N²)
// The `cache` is a 2D array of size N x N for memoization. The recursion depth
// also adds O(N) to the call stack, but the cache size is the dominant factor.
class Solution {
    func minScoreTriangulation(_ values: [Int]) -> Int {

        // `cache` stores results of subproblems to avoid re-computation (memoization).
        // cache[l][r] will hold the minimum score to triangulate the polygon
        // formed by vertices from index l to r.
        var cache: [[Int?]] = Array(
            repeating: Array(repeating: nil, count: values.count),
            count: values.count
        )

        // `sum` is a recursive function that finds the minimum score for a
        // sub-polygon defined by the vertices from `values[l]` to `values[r]`.
        func sum(_ l: Int = 0, _ r: Int = values.count - 1) -> Int {
            // If the result for subproblem (l, r) is already cached, return it.
            if let c = cache[l][r] { return c }

            // Base case 1: If there are fewer than 3 vertices (e.g., just an edge),
            // no triangles can be formed, so the score is 0.
            guard r - l >= 2 else { return 0 }
            
            // Base case 2: An optimization for the smallest polygon, a single triangle.
            // This happens when `r == l + 2`. The score is the product of the three vertex values.
            // Note: `values[l+2]` is used here, which is equivalent to `values[r]` for this case.
            guard r - l > 2 else { return values[l] * values[l + 1] * values[l + 2] }

            var res = Int.max

            // This is the core recursive step. We fix the edge (l, r) of the sub-polygon.
            // Then, iterate through all possible intermediate vertices 'i' (where l < i < r)
            // to form a triangle `(l, i, r)`.
            for i in 1 + l...r - 1 {
                // This choice of triangle `(l, i, r)` splits the larger polygon into two
                // smaller, independent sub-polygons which are solved recursively.
                
                // Total score = (score of new triangle) + (min score of left sub-polygon) + (min score of right sub-polygon)
                let currentScore = values[l] * values[r] * values[i] + sum(l, i) + sum(i, r)
                res = min(res, currentScore)
            }

            // Cache the result for the current subproblem (l, r) before returning.
            cache[l][r] = res

            return res
        }

        // Start the recursion for the entire polygon, from vertex 0 to the last vertex.
        return sum()
    }
}