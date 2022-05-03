class Solution {
    func minFallingPathSum(_ matrix: [[Int]]) -> Int {
        var mutableMatrix = matrix
        let rowsCount = mutableMatrix.count
        let columnsCount = mutableMatrix[0].count
        
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