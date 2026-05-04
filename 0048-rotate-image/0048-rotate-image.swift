/**
 Problem Summary:
 Rotate an n x n 2D matrix by 90 degrees clockwise in-place.

 Strategy:
 The rotation is achieved in two steps:
 1. Transpose the matrix (swap rows with columns).
    - Convert element at (i, j) to (j, i)
 2. Reverse each row.
    - This completes the 90-degree clockwise rotation.

 Key Insight:
 A clockwise rotation = Transpose + Reverse each row

 Time Complexity:
 O(n^2) — every element is visited once during transpose and once during reversal.

 Space Complexity:
 O(1) — in-place transformation, no extra space used.
 */

class Solution {
    func rotate(_ matrix: inout [[Int]]) {
        let size = matrix.count
        
        // Step 1: Transpose the matrix
        // Swap elements across the diagonal (i, j) <-> (j, i)
        for row in 0..<size {
            for col in row..<size {
                let temp = matrix[row][col]
                matrix[row][col] = matrix[col][row]
                matrix[col][row] = temp
            }
        }
        
        // Step 2: Reverse each row
        // Swap elements symmetrically from left to right
        for row in 0..<size {
            for col in 0..<(size / 2) {
                let oppositeCol = size - 1 - col
                let temp = matrix[row][col]
                matrix[row][col] = matrix[row][oppositeCol]
                matrix[row][oppositeCol] = temp
            }
        }
    }
}