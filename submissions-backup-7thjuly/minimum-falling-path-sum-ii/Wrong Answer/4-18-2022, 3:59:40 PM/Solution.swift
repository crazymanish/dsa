// https://leetcode.com/problems/minimum-falling-path-sum-ii

class Solution {
    func minFallingPathSum(_ grid: [[Int]]) -> Int {
        var mutableMatrix = grid
        let rowsCount = mutableMatrix.count
        let columnsCount = mutableMatrix[0].count
        
        // Update matrix with minimum failing path
        // Skip first row because that will always hold minimum value in matrix
        for row in 1..<rowsCount {
            for column in 0..<columnsCount {
                var minimumValue = Int.max
                
                if column > 0 {
                    let diagnalLeftValue = mutableMatrix[row-1][column-1]
                    minimumValue = min(minimumValue, diagnalLeftValue)
                } else if column < columnsCount-1 {
                    let diagnalRightValue = mutableMatrix[row-1][column+1]
                    minimumValue = min(minimumValue, diagnalRightValue)
                } else {
                    minimumValue = 0
                }
                
                mutableMatrix[row][column] += minimumValue
            }
        }
        
        // minimum value in last row will hold the answer
        var minFallingPathSum = Int.max
        for value in mutableMatrix[rowsCount-1] {
            minFallingPathSum = min(minFallingPathSum, value)
        }
        
        return minFallingPathSum
    }
}