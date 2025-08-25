// Time Complexity: O(M * N)
//   - M: The number of rows in the matrix.
//   - N: The number of columns in the matrix.
//   - The algorithm has two main stages:
//     1. Populating the dictionary: We iterate through every cell of the M x N matrix once. This is O(M * N).
//     2. Assembling the result: We iterate through the diagonals (up to M+N-2 of them) and append
//        their contents to the result array. In total, all M*N elements are appended exactly once.
//        Reversing some diagonals also contributes, but the total work remains proportional to M*N.
//   - Therefore, the overall time complexity is O(M * N), which is optimal as we must visit every element.
//
// Space Complexity: O(M * N)
//   - The `diagonals` dictionary stores all M * N elements of the matrix, grouped by key.
//   - The `result` array also grows to hold all M * N elements.
//   - Therefore, the space required is proportional to the size of the matrix.
//   - (Note: A simulation-based approach exists that uses O(1) extra space but has more complex boundary-checking logic).
class Solution {
    /**
     * Returns the elements of a matrix in diagonal traversal order.
     *
     * The strategy is to group all matrix elements by the diagonal they belong to. A key insight
     * is that for any given diagonal, the sum of the row and column indices `r + c` is constant.
     * We can use this sum as a key in a dictionary to collect all elements for each diagonal.
     *
     * Once grouped, we iterate through the diagonals in order (from key 0 upwards) and append
     * them to our result. The direction of traversal alternates:
     * - Even-numbered diagonals (key 0, 2, 4...) are traversed upwards (requiring us to reverse the collected elements).
     * - Odd-numbered diagonals (key 1, 3, 5...) are traversed downwards (using the natural collection order).
     *
     * - Parameter mat: An M x N matrix of integers.
     * - Returns: A 1D array containing the elements in diagonal order.
     */
    func findDiagonalOrder(_ mat: [[Int]]) -> [Int] {
        guard let firstRow = mat.first, !firstRow.isEmpty else { return [] }
        
        let rows = mat.count
        let cols = firstRow.count

        // A dictionary to group elements by their diagonal index (r + c).
        var diagonals = [Int: [Int]]()
        var maxDiagonalKey = 0

        // Step 1: Populate the dictionary by iterating through the matrix.
        for r in 0..<rows {
            for c in 0..<cols {
                let diagonalKey = r + c
                diagonals[diagonalKey, default: []].append(mat[r][c])
                maxDiagonalKey = max(maxDiagonalKey, diagonalKey)
            }
        }

        var result = [Int]()

        // Step 2: Assemble the final list by traversing the diagonals.
        for key in 0...maxDiagonalKey {
            guard let diagonalElements = diagonals[key] else { continue }
            
            if key % 2 == 0 { // Even diagonals go up-right.
                // Our dictionary values are built by scanning top-to-bottom, left-to-right.
                // For an up-right traversal, we need to reverse this order.
                // e.g., for key=2, we collect [mat[0][2], mat[1][1], mat[2][0]], but need [mat[2][0], mat[1][1], mat[0][2]].
                result.append(contentsOf: diagonalElements.reversed())
            } else { // Odd diagonals go down-left.
                // The natural collection order matches the down-left traversal direction.
                result.append(contentsOf: diagonalElements)
            }
        }

        return result
    }
}