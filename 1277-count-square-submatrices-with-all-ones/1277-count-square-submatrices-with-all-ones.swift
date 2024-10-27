class Solution {
    func countSquares(_ matrix: [[Int]]) -> Int {
        var mutableMatrix = matrix
        let rowsCount = mutableMatrix.count
        let columnsCount = mutableMatrix[0].count
        
        var outputCounter = 0
        
        // count for Last Row
        let lastRow = rowsCount-1
        for column in 0..<columnsCount {
            if mutableMatrix[lastRow][column] == 1 {
                outputCounter += 1
            }
        }
        
        // count for Last Column
        let lastColumn = columnsCount-1
        for row in 0..<rowsCount-1 {
            if mutableMatrix[row][lastColumn] == 1 {
                outputCounter += 1
            }
        }
        
        // count for rest...
        for row in (0..<lastRow).reversed() {
            for column in (0..<lastColumn).reversed() {
                if mutableMatrix[row][column] == 1 {
                    let rightValue = mutableMatrix[row][column+1]
                    let downValue = mutableMatrix[row+1][column]
                    let diagnalValue = mutableMatrix[row+1][column+1]
                    
                    let minimumValue = min(min(rightValue, downValue), diagnalValue)

                    let squareValue = 1 + minimumValue
                    mutableMatrix[row][column] = squareValue
                    
                    outputCounter += squareValue
                }
            }
        }
        
        return outputCounter
    }
}