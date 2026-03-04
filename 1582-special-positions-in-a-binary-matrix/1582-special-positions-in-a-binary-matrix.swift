class Solution {
    /**
     -----------------------------------------------------------------------
     Problem Summary:
        Given a binary matrix `mat`, return the number of special positions.

        A position (row, col) is considered special if:
        - mat[row][col] == 1
        - All other elements in that row are 0
        - All other elements in that column are 0

     Strategy:
        1. First pass:
           - Count how many 1s exist in each row.
           - Count how many 1s exist in each column.

        2. Second pass:
           - For each cell that contains 1,
             check whether its row count == 1 AND column count == 1.
           - If so, it is a special position.

        This avoids repeatedly scanning rows and columns.

     Time Complexity:
        O(m × n)
        - We traverse the matrix twice.

     Space Complexity:
        O(m + n)
        - Row counts array of size m.
        - Column counts array of size n.
     -----------------------------------------------------------------------
     */

    func numSpecial(_ matrix: [[Int]]) -> Int {
        let rowCount = matrix.count
        let columnCount = matrix[0].count

        // Stores number of 1s in each row
        var onesPerRow = [Int](repeating: 0, count: rowCount)

        // Stores number of 1s in each column
        var onesPerColumn = [Int](repeating: 0, count: columnCount)

        // First pass: count 1s per row and per column
        for row in 0..<rowCount {
            for column in 0..<columnCount {
                if matrix[row][column] == 1 {
                    onesPerRow[row] += 1
                    onesPerColumn[column] += 1
                }
            }
        }

        var specialPositionCount = 0

        // Second pass: validate special positions
        for row in 0..<rowCount {
            for column in 0..<columnCount {
                if matrix[row][column] == 1 &&
                    onesPerRow[row] == 1 &&
                    onesPerColumn[column] == 1 {

                    specialPositionCount += 1
                }
            }
        }

        return specialPositionCount
    }
}