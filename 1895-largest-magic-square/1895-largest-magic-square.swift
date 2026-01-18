class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(rows * cols * size³) in the worst case
    ///
    /// Space Complexity:
    ///   • O(1)
    ///
    /// Summary:
    ///   Find the largest square subgrid where:
    ///     - All rows have equal sums
    ///     - All columns have equal sums
    ///     - Both diagonals have equal sums
    /// -----------------------------------------------------------------------
    func largestMagicSquare(_ grid: [[Int]]) -> Int {
        let totalRows = grid.count
        let totalCols = grid[0].count
        
        // Any single cell is trivially a magic square
        var maxMagicSize = 1
        
        // Try increasing square sizes
        var squareSize = 2
        while squareSize <= min(totalRows, totalCols) {
            var foundSquareOfThisSize = false
            
            // Try every possible top-left corner for this size
            for topRow in 0...(totalRows - squareSize) {
                for leftCol in 0...(totalCols - squareSize) {
                    if isValidMagicSquare(grid: grid, topRow: topRow, leftCol: leftCol, size: squareSize) {
                        maxMagicSize = squareSize
                        foundSquareOfThisSize = true
                        break
                    }
                }

                if foundSquareOfThisSize { break }
            }
            
            squareSize += 1
        }
        
        return maxMagicSize
    }
    
    /// Determines whether the square subgrid starting at (topRow, leftCol)
    /// with side length `size` is a magic square.
    private func isValidMagicSquare(grid: [[Int]], topRow: Int, leftCol: Int, size: Int) -> Bool {
        var mainDiagonalSum = 0
        var antiDiagonalSum = 0
        
        // Calculate both diagonal sums
        for offset in 0..<size {
            mainDiagonalSum += grid[topRow + offset][leftCol + offset]
            antiDiagonalSum += grid[topRow + offset][leftCol + size - 1 - offset]
        }
        
        // Diagonals must match
        if mainDiagonalSum != antiDiagonalSum {
            return false
        }
        
        // Validate each row and column sum
        for index in 0..<size {
            var currentRowSum = 0
            var currentColSum = 0
            
            for offset in 0..<size {
                currentRowSum += grid[topRow + index][leftCol + offset]
                currentColSum += grid[topRow + offset][leftCol + index]
            }
            
            if currentRowSum != mainDiagonalSum || currentColSum != mainDiagonalSum {
                return false
            }
        }
        
        return true
    }
}
