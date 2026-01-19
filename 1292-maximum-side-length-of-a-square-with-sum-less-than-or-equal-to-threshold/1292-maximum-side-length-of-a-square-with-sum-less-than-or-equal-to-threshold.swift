class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(m * n)
    ///     - m = number of rows
    ///     - n = number of columns
    ///     Each cell is processed once while building prefix sums.
    ///
    /// Space Complexity:
    ///   • O(m * n)
    ///     - 2D prefix sum matrix of size (m + 1) × (n + 1).
    ///
    /// Problem Summary:
    ///   Given a matrix of non-negative integers, find the maximum side length
    ///   of a square such that the sum of its elements is less than or equal
    ///   to the given threshold.
    ///
    /// Approach:
    ///   - Use a 2D prefix sum matrix to compute submatrix sums in O(1).
    ///   - Incrementally try to expand the square size whenever possible.
    /// -----------------------------------------------------------------------
    func maxSideLength(_ matrix: [[Int]], _ threshold: Int) -> Int {
        let rowCount = matrix.count
        let colCount = matrix[0].count
        
        // prefixSum[r][c] stores sum of submatrix from (0,0) to (r-1,c-1)
        var prefixSum = Array(
            repeating: Array(repeating: 0, count: colCount + 1),
            count: rowCount + 1
        )
        
        var maxValidSide = 0
        var candidateSide = 1
        
        // Build prefix sums row by row
        for row in 1...rowCount {
            for col in 1...colCount {
                prefixSum[row][col] =
                    prefixSum[row - 1][col] +
                    prefixSum[row][col - 1] -
                    prefixSum[row - 1][col - 1] +
                    matrix[row - 1][col - 1]
                
                // Check if we can form a square of size `candidateSide`
                // ending at (row, col)
                if row >= candidateSide && col >= candidateSide {
                    let squareSum = prefixSum[row][col]
                        - prefixSum[row - candidateSide][col]
                        - prefixSum[row][col - candidateSide]
                        + prefixSum[row - candidateSide][col - candidateSide]
                    
                    if squareSum <= threshold {
                        maxValidSide = candidateSide
                        candidateSide += 1
                    }
                }
            }
        }
        
        return maxValidSide
    }
}
