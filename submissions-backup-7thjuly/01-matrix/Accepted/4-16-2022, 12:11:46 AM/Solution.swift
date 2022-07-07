// https://leetcode.com/problems/01-matrix

class Solution {    
    func updateMatrix(_ mat: [[Int]]) -> [[Int]] {
        let rowsCount = mat.count
        let columnsCount = mat[0].count
        let maxValue = rowsCount*columnsCount
        var outputMatrix = Array(repeating: Array(repeating: maxValue, count: columnsCount), count: rowsCount)
        
        for row in 0..<rowsCount {
            for column in 0..<columnsCount {
                if mat[row][column] == 0 {
                    outputMatrix[row][column] = 0 
                    continue
                }
                
                // Top + left
                if row > 0 { outputMatrix[row][column] = outputMatrix[row-1][column] + 1 } 
                if column > 0 { outputMatrix[row][column] = min(outputMatrix[row][column], outputMatrix[row][column-1] + 1) } 
            }
        }
        
        for row in (0..<rowsCount).reversed() {
            for column in (0..<columnsCount).reversed() {
                if mat[row][column] == 0 { continue }
                
                // Down + Right
                if row < rowsCount - 1 { outputMatrix[row][column] = min(outputMatrix[row][column], outputMatrix[row+1][column] + 1) }
                if column < columnsCount - 1 { outputMatrix[row][column] = min(outputMatrix[row][column], outputMatrix[row][column+1] + 1) }
            }
        }
        
        return outputMatrix
    }
}