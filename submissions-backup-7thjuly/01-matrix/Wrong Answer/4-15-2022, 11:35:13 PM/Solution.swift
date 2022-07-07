// https://leetcode.com/problems/01-matrix

class Solution {
    func updateMatrix(_ mat: [[Int]]) -> [[Int]] {
        var mutableMatrix = mat
        let rowsCount = mutableMatrix.count
        let columnsCount = mutableMatrix[0].count
        
        let lastRow = rowsCount-1
        let lastColumn = columnsCount-1
        
        for row in (0...lastRow) {
            for column in (0...lastColumn) {
                if mutableMatrix[row][column] == 1 {
                    let leftValue = column == 0 ? 0 : mutableMatrix[row][column-1]
                    let upValue = row == 0 ? 0 : mutableMatrix[row-1][column]
                    
                    let minimumValue = min(leftValue, upValue)
                    mutableMatrix[row][column] = 1 + minimumValue
                }
            }
        }
        
        for row in (0...lastRow).reversed() {
            for column in (0...lastColumn).reversed() {
                if mutableMatrix[row][column] == 1 {
                    let rightValue = column == lastColumn ? 0 : mutableMatrix[row][column+1]
                    let downValue = row == lastRow ? 0 : mutableMatrix[row+1][column]
                    
                    let minimumValue = min(rightValue, downValue)
                    mutableMatrix[row][column] = 1 + minimumValue
                }
            }
        }
        
        return mutableMatrix
    }
}