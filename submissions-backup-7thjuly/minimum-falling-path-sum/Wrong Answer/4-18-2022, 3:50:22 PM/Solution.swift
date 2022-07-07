// https://leetcode.com/problems/minimum-falling-path-sum

class Solution {
    func minFallingPathSum(_ matrix: [[Int]]) -> Int {
        var mutableMatrix = matrix
        let rowsCount = mutableMatrix.count
        let columnsCount = mutableMatrix[0].count
        
        var minFallingPathSum = Int.max
        
        // Update matrix with minimum failing path
        // Skip first row because that will always hold minimum value in matrix
        for row in 1..<rowsCount {
            for column in 0..<columnsCount {
                var minimumValue = Int.max
                
                let downValue = mutableMatrix[row-1][column]
                minimumValue = min(minimumValue, downValue)
                
                if column > 0 {
                    let diagnalLeftValue = mutableMatrix[row-1][column-1]
                    minimumValue = min(minimumValue, diagnalLeftValue)
                }
                
                if column < columnsCount-1 {
                    let diagnalRightValue = mutableMatrix[row-1][column+1]
                    minimumValue = min(minimumValue, diagnalRightValue)
                }
                
                mutableMatrix[row][column] += minimumValue
                
                if row == rowsCount-1 { // minimum value in last row will hold the answer
                    minFallingPathSum = min(minFallingPathSum, mutableMatrix[row][column])
                }
            }
        }
        
        return minFallingPathSum
    }
}