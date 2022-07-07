// https://leetcode.com/problems/minimum-path-sum

class Solution {
    func minPathSum(_ grid: [[Int]]) -> Int {
        var matrix = grid
        let rows = matrix.count
        let columns = matrix[0].count
        
        for row in (0..<rows).reversed() {
            for column in (0..<columns).reversed() {
                let isLastRow = row == rows-1
                let isLastColumn = column == columns-1
                
                if isLastRow && isLastColumn { continue }
                
                let downValue = isLastRow ? Int.max : matrix[row+1][column]
                let rightValue = isLastColumn ? Int.max : matrix[row][column+1]
                
                matrix[row][column] += min(downValue, rightValue)
            }    
        }
        
        return matrix[0][0]
    }
}