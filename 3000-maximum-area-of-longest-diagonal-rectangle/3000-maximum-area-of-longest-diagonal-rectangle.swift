// Time Complexity: O(N)
//   - N: The number of rectangles in the `dimensions` array.
//   - The algorithm iterates through the input array exactly once. All operations
//     inside the loop (multiplication, addition, comparison) are constant time.
//   - Therefore, the runtime is linear with respect to the number of rectangles.
//
// Space Complexity: O(1)
//   - The solution uses a fixed number of variables (`maxDiagonalSquared`, `maxArea`)
//     to keep track of the result. The amount of memory used does not scale
//     with the size of the input array.
class Solution {
    /**
     * Finds the area of the rectangle with the longest diagonal.
     * If there's a tie for the longest diagonal, it returns the largest area among them.
     *
     * The strategy is to iterate through each rectangle while keeping track of two things:
     * 1. The maximum diagonal length found so far.
     * 2. The area associated with that maximum diagonal.
     *
     * To optimize, we compare the square of the diagonals (l² + w²) instead of the
     * diagonals themselves. This avoids computationally expensive square root operations and
     * potential floating-point precision issues, since comparing d₁ and d₂ is equivalent
     * to comparing d₁² and d₂².
     *
     * - Parameter dimensions: An array of `[length, width]` pairs for each rectangle.
     * - Returns: The area of the rectangle that meets the criteria.
     */
    func areaOfMaxDiagonal(_ dimensions: [[Int]]) -> Int {
        // Guard against empty input to prevent crashes.
        guard !dimensions.isEmpty else { return 0 }

        var maxDiagonalSquared = -1 // Initialize with a value smaller than any possible result.
        var maxArea = 0

        // Perform a single pass through all the rectangles.
        for rectangle in dimensions {
            let length = rectangle[0]
            let width = rectangle[1]
            
            // Calculate the square of the diagonal length.
            let diagonalSquared = length * length + width * width
            
            if diagonalSquared > maxDiagonalSquared {
                // If we find a new, longer diagonal:
                // 1. Update the max diagonal squared.
                // 2. Reset the max area to the area of *this* rectangle.
                maxDiagonalSquared = diagonalSquared
                maxArea = length * width
            } else if diagonalSquared == maxDiagonalSquared {
                // If we find a rectangle with the same diagonal length (a tie):
                // 1. We only update the max area if the current rectangle's area is larger.
                maxArea = max(maxArea, length * width)
            }
        }
        
        return maxArea
    }
}