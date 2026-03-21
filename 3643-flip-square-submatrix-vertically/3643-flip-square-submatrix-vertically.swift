class Solution {
    /**
     Problem Summary:
     Reverse a k x k submatrix within the given grid, starting at position (x, y).
     The reversal is performed vertically (top rows swapped with bottom rows).

     Strategy:
     - Use two pointers:
       - topRow starting at x
       - bottomRow starting at x + k - 1
     - Swap corresponding elements column-wise between topRow and bottomRow
     - Move pointers inward until they meet

     Time Complexity:
     O(k^2) — we iterate over each element in the k x k submatrix

     Space Complexity:
     O(1) — in-place modification (ignoring output copy)
     */
    func reverseSubmatrix(_ grid: [[Int]], _ x: Int, _ y: Int, _ k: Int) -> [[Int]] {
        var resultGrid = grid
        
        var topRow = x
        var bottomRow = x + k - 1
        
        // Continue swapping rows until pointers meet or cross
        while topRow < bottomRow {
            for column in y..<(y + k) {
                // Swap elements between topRow and bottomRow for each column
                let temp = resultGrid[topRow][column]
                resultGrid[topRow][column] = resultGrid[bottomRow][column]
                resultGrid[bottomRow][column] = temp
            }
            
            // Move pointers inward
            topRow += 1
            bottomRow -= 1
        }
        
        return resultGrid
    }
}