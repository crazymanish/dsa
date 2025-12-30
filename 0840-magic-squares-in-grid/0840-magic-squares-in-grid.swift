/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(m * n)
///     - m = number of rows, n = number of columns
///     - We check every possible 3×3 subgrid once.
///     - Each check is O(1) (fixed-size work).
///
/// Space Complexity:
///   • O(1)
///     - Only constant extra space is used.
///
/// Problem Summary:
///   Count how many 3×3 subgrids are "magic squares".
///   A magic square must:
///     1. Contain all numbers from 1 to 9 exactly once.
///     2. Have every row, column, and diagonal sum to 15.
/// ---------------------------------------------------------------------------
class Solution {
    func numMagicSquaresInside(_ grid: [[Int]]) -> Int {
        let rowCount = grid.count
        let colCount = grid[0].count
        
        // Not enough space to form a 3×3 square
        if rowCount < 3 || colCount < 3 {
            return 0
        }
        
        // Helper to validate a flattened 3×3 square
        func isMagicSquare(_ values: [Int]) -> Bool {
            // Must contain exactly numbers 1 through 9
            if values.sorted() != Array(1...9) {
                return false
            }
            
            // Indices representing all rows, columns, and diagonals
            let lines = [
                [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
                [0, 3, 6], [1, 4, 7], [2, 5, 8], // columns
                [0, 4, 8], [2, 4, 6]             // diagonals
            ]
            
            // Every line must sum to 15
            for line in lines {
                let sum = values[line[0]] + values[line[1]] + values[line[2]]
                if sum != 15 {
                    return false
                }
            }
            
            return true
        }
        
        var magicSquareCount = 0
        
        // Iterate over all possible centers of a 3×3 square
        for row in 1..<(rowCount - 1) {
            for col in 1..<(colCount - 1) {
                
                // Extract the 3×3 square centered at (row, col)
                let squareValues = grid[(row - 1)...(row + 1)]
                    .flatMap { $0[(col - 1)...(col + 1)] }
                
                if isMagicSquare(squareValues) {
                    magicSquareCount += 1
                }
            }
        }
        
        return magicSquareCount
    }
}
