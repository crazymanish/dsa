class Solution {
    func minFallingPathSum(_ grid: [[Int]]) -> Int {
        var mutableMatrix = grid
        let rowsCount = mutableMatrix.count
        let columnsCount = mutableMatrix[0].count
        
        // Update matrix with minimum failing path
        // Skip first row because that will always hold minimum value in matrix
        for row in 1..<rowsCount {
            for column in 0..<columnsCount {
                mutableMatrix[row][column] += findMinValue(row, column)
            }
        }
        
        func findMinValue(_ row: Int, _ column: Int) -> Int {
            var minElement = Int.max
            
            for (index, value) in mutableMatrix[row-1].enumerated() {
                if index == column { continue } // skip for same column
                minElement = min(minElement, value)
            }
            
            return minElement == Int.max ? 0 : minElement
        }
        
        // minimum value in last row will hold the answer
        var minFallingPathSum = Int.max
        for value in mutableMatrix[rowsCount-1] {
            minFallingPathSum = min(minFallingPathSum, value)
        }
        
        return minFallingPathSum
    }
}