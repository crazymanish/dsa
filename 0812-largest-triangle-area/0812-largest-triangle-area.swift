// Time Complexity: O(N³)
// We use a brute-force approach with three nested loops to iterate through every
// possible combination of three points from the input list of N points. This is the
// dominant factor in the runtime.
//
// Space Complexity: O(1)
// The algorithm uses a constant amount of extra space for variables, regardless
// of the input size.
class Solution {
    func largestTriangleArea(_ points: [[Int]]) -> Double {
        // Variable to store the maximum area found so far.
        var maxArea: Double = 0
        
        // Brute-force: Iterate through every possible combination of three distinct points.
        // The loop bounds (y starts from x+1, z starts from y+1) ensure that
        // each unique triplet {points[x], points[y], points[z]} is checked exactly once.
        for x in 0..<points.count - 2 {
            for y in (x + 1)..<points.count - 1 {
                for z in (y + 1)..<points.count {
                    // Calculate the area for the current triplet and update maxArea if it's larger.
                    maxArea = max(maxArea, area(points[x], points[y], points[z]))
                }
            }
        }
        return maxArea
    }
    
    // Helper function to calculate a triangle's area using the Shoelace Formula.
    // This specific implementation is derived from the cross-product of two vectors
    // that share a common vertex (in this case, point 'x').
    private func area(_ x: [Int], _ y: [Int], _ z: [Int]) -> Double {
        // The formula calculates half the magnitude of the cross-product of vectors (y-x) and (z-x).
        // Area = 0.5 * |(y₀ - x₀)(z₁ - x₁) - (z₀ - x₀)(y₁ - x₁)|
        abs(Double((y[0] - x[0]) * (z[1] - x[1]) - (z[0] - x[0]) * (y[1] - x[1]))) / 2.0
    }
}