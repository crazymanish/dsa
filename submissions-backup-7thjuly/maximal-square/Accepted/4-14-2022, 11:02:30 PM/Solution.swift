// https://leetcode.com/problems/maximal-square

class Solution {
    // This solution is based on previous/below question
    // 1277. Count Square Submatrices with All Ones
    // https://leetcode.com/problems/count-square-submatrices-with-all-ones/
    func maximalSquare(_ matrix: [[Character]]) -> Int {
        var mutableMatrix = matrix.map { $0.map { String($0) } }
        let rowsCount = mutableMatrix.count
        let columnsCount = mutableMatrix[0].count
        
        var maximalSquareCount = 0
        
        // check in Last Row, if we have 1 or not
        let lastRow = rowsCount-1
        for column in 0..<columnsCount {
            if mutableMatrix[lastRow][column] == "1" {
                maximalSquareCount = 1
                break
            }
        }
        
        // check in Last Column, if we have 1 or not (only if we did not found in last row)
        let lastColumn = columnsCount-1
        if maximalSquareCount == 0 {
            for row in 0..<rowsCount-1 {
                if mutableMatrix[row][lastColumn] == "1" {
                    maximalSquareCount = 1
                    break
                }
            }
        }
        
        // check the rest row, column for maximum square...
        for row in (0..<lastRow).reversed() {
            for column in (0..<lastColumn).reversed() {
                if mutableMatrix[row][column] == "1" {
                    let rightValue = mutableMatrix[row][column+1]
                    let downValue = mutableMatrix[row+1][column]
                    let diagnalValue = mutableMatrix[row+1][column+1]
                    
                    let minimumValue = min(min(Int(rightValue)!, Int(downValue)!), Int(diagnalValue)!)

                    let squareValue = 1 + minimumValue
                    mutableMatrix[row][column] = String(squareValue)
                    
                    maximalSquareCount = max(maximalSquareCount, squareValue)
                }
            }
        }
        
        return maximalSquareCount*maximalSquareCount
    }
}