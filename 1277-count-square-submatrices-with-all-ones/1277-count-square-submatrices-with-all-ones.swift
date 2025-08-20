// Time Complexity: O(M * N)
// The algorithm iterates through each cell of the M x N matrix exactly once.
// The work done at each cell (comparison, min, addition) is constant time.
// Therefore, the total time complexity is linear with respect to the number of cells in the matrix.
//
// Space Complexity: O(1)
// This solution modifies the input matrix in-place to serve as the DP table, thus not
// requiring any extra space that scales with the input size. If modifying the input
// is not allowed, a copy would be needed, resulting in O(M * N) space complexity.
class Solution {
    /**
     * Counts the total number of square submatrices with all ones in a given matrix.
     *
     * This solution uses dynamic programming. We define `dp[i][j]` as the side length
     * of the largest square of ones whose bottom-right corner is at cell `(i, j)`.
     *
     * The key insight is that `dp[i][j]` also represents the *total number* of squares
     * that have `(i, j)` as their bottom-right corner. For example, if the largest
     * square is 3x3, there must also be 2x2 and 1x1 squares ending at the same corner.
     * Thus, the total count is simply the sum of all values in our DP table.
     *
     * The DP transition is:
     * If matrix[i][j] is 1, then dp[i][j] = 1 + min(dp[i-1][j], dp[i][j-1], dp[i-1][j-1]).
     * Otherwise, dp[i][j] = 0.
     *
     * - Parameter matrix: An M x N matrix of 0s and 1s.
     * - Returns: The total number of square submatrices containing all ones.
     */
    func countSquares(_ matrix: [[Int]]) -> Int {
        guard !matrix.isEmpty, !matrix[0].isEmpty else { return 0 }

        var dpMatrix = matrix
        let rows = dpMatrix.count
        let cols = dpMatrix[0].count
        var totalSquares = 0

        for row in 0..<rows {
            for col in 0..<cols {
                // We only care about cells that contain a 1.
                if dpMatrix[row][col] == 1 {
                    
                    // Base Case: For the first row or first column, a '1' can only form a 1x1 square.
                    // The `dpMatrix` already has the value 1, so no change is needed.
                    // We proceed to the recursive step for all other cells.
                    if row > 0 && col > 0 {
                        // The size of the square ending at (row, col) is limited by its neighbors
                        // to the top, left, and top-left diagonal.
                        let top = dpMatrix[row - 1][col]
                        let left = dpMatrix[row][col - 1]
                        let topLeft = dpMatrix[row - 1][col - 1]
                        
                        dpMatrix[row][col] = 1 + min(top, left, topLeft)
                    }
                }
                
                // Add the value at dpMatrix[row][col] to the total count.
                // This value represents how many squares have (row, col) as their bottom-right corner.
                totalSquares += dpMatrix[row][col]
            }
        }
        
        return totalSquares
    }
}