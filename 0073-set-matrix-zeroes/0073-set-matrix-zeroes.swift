/*
Time Complexity: O(M * N)
- The algorithm involves three passes over parts of the matrix:
    - The first pass (setting markers): Iterates through all M * N cells. -> O(M * N)
    - The second pass (zeroing based on markers): Iterates through (M-1) * (N-1) cells. -> O(M * N)
    - The final pass (zeroing first row/column): Iterates through M cells for the column and N cells for the row in the worst case. -> O(M + N)
- The dominant factor is M * N.
- Total Time Complexity: O(M * N)

Space Complexity: O(1)
- The algorithm modifies the input matrix in-place.
- It uses only a constant amount of extra space for the two boolean flags (`shouldZeroFirstRow`, `shouldZeroFirstColumn`).
- Total Space Complexity: O(1)
*/
class Solution {
    func setZeroes(_ matrix: inout [[Int]]) {
        let numberOfRows = matrix.count // Get the total number of rows in the matrix
        let numberOfColumns = matrix[0].count // Get the total number of columns in the matrix

        // Flags to determine if the very first row or very first column needs to be zeroed out.
        // We use the first row/column themselves as markers for other rows/columns,
        // so we need separate flags for row 0 and column 0.
        var shouldZeroFirstRow = false
        var shouldZeroFirstColumn = false

        // First Pass: Identify which rows and columns need to be zeroed.
        // We use the first cell of a row (matrix[r][0]) to mark if row 'r' should be zeroed.
        // We use the first cell of a column (matrix[0][c]) to mark if column 'c' should be zeroed.
        // Special handling is needed for row 0 and column 0 themselves, hence the flags.
        // Time: O(rows * cols)
        for rowIdx in 0..<numberOfRows {
            for colIdx in 0..<numberOfColumns {
                if matrix[rowIdx][colIdx] == 0 {
                    // If a zero is found in the very first row, set its flag
                    if rowIdx == 0 { 
                        shouldZeroFirstRow = true 
                    }
                    // If a zero is found in the very first column, set its flag
                    if colIdx == 0 { 
                        shouldZeroFirstColumn = true 
                    }
                    
                    // Mark the corresponding first row/column cell as 0
                    // This serves as a marker for the entire row/column
                    matrix[rowIdx][0] = 0 // Mark current row
                    matrix[0][colIdx] = 0 // Mark current column
                }
            }
        }
        
        // Second Pass: Use the markers in the first row and first column to zero out the rest of the matrix.
        // We iterate from (1,1) to avoid using the markers (matrix[0][0] onwards) prematurely.
        // Time: O(rows * cols)
        for rowIdx in 1..<numberOfRows {
            for colIdx in 1..<numberOfColumns {
                // If the marker in the first column of the current row (matrix[rowIdx][0]) is 0,
                // OR the marker in the first row of the current column (matrix[0][colIdx]) is 0,
                // then this cell (matrix[rowIdx][colIdx]) should be set to 0.
                if matrix[rowIdx][0] == 0 || matrix[0][colIdx] == 0 {
                    matrix[rowIdx][colIdx] = 0
                }
            }
        }

        // Final Pass: Zero out the first row and first column if their respective flags were set.
        // This step must be performed last to ensure that the markers stored in row 0 and col 0
        // are used before they themselves are potentially zeroed out.
        // Time: O(rows + cols)

        // If the first row was marked for zeroing
        if shouldZeroFirstRow {
            for colIdx in 0..<numberOfColumns {
                matrix[0][colIdx] = 0 // Set all elements in the first row to 0
            }
        }

        // If the first column was marked for zeroing
        if shouldZeroFirstColumn {
            for rowIdx in 0..<numberOfRows {
                matrix[rowIdx][0] = 0 // Set all elements in the first column to 0
            }
        }
    }
}
