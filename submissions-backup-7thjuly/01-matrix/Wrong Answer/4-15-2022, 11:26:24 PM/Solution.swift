// https://leetcode.com/problems/01-matrix

class Solution {
    func updateMatrix(_ mat: [[Int]]) -> [[Int]] {
        var mutableMatrix = mat
        let rowsCount = mutableMatrix.count
        let columnsCount = mutableMatrix[0].count
        
        let lastRow = rowsCount-1
        let lastColumn = columnsCount-1
        
        for row in (0...lastRow).reversed() {
            for column in (0...lastColumn).reversed() {
                if mutableMatrix[row][column] == 1 {
                    let leftValue = column == 0 ? 1 : mutableMatrix[row][column-1]
                    let rightValue = column == lastColumn ? 1 : mutableMatrix[row][column+1]
                    let upValue = row == 0 ? 1 : mutableMatrix[row-1][column]
                    let downValue = row == lastRow ? 1 : mutableMatrix[row+1][column]
                    
                    let minimumLeftRightValue = min(leftValue, rightValue)
                    let minimumUpDownValue = min(upValue, downValue)
                    let minimumValue = min(minimumLeftRightValue, minimumUpDownValue)

                    mutableMatrix[row][column] = 1 + minimumValue
                }
            }
        }
        
        return mutableMatrix
    }
}