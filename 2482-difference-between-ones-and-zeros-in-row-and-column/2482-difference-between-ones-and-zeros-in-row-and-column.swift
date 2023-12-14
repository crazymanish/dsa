class Solution {
    func onesMinusZeros(_ grid: [[Int]]) -> [[Int]] {
        let rows = grid.count
        let columns = grid[0].count
        var totalOneInrow = Array(repeating:0, count:rows)
        var totalZeroInRow = Array(repeating:0, count:rows)
        var totalOneInCol = Array(repeating:0, count:columns)
        var totalZeroInCol = Array(repeating:0, count:columns)

        for row in 0..<rows {
            for column in 0..<columns {
                if (grid[row][column] == 1) {
                    totalOneInrow[row] = totalOneInrow[row] + 1
                    totalOneInCol[column] = totalOneInCol[column] + 1

                } else {
                    totalZeroInRow[row] = totalZeroInRow[row] + 1
                    totalZeroInCol[column] = totalZeroInCol[column] + 1
                }
                
            }
        }

        var diff = Array(repeating: Array(repeating: 0, count: columns), count: rows)
        
        for row in 0..<rows {
            for column in 0..<columns {
                diff[row][column] = totalOneInrow[row] + totalOneInCol[column] - totalZeroInRow[row] - totalZeroInCol[column]
            }
        }

        return diff

    }
}