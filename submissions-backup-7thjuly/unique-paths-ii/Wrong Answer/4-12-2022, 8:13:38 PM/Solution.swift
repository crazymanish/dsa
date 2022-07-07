// https://leetcode.com/problems/unique-paths-ii

class Solution {
    func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
        let m = obstacleGrid.count
        let n = obstacleGrid[0].count
        
        var lastRow = obstacleGrid.last!
        for index in 0..<lastRow.count { lastRow[index] = 1-lastRow[index] }
        
        for rowIndex in (0..<m-1).reversed() { // m-1 (because we already have last row) 
            var currentRow = obstacleGrid[rowIndex]
            for index in 0..<currentRow.count { currentRow[index] = 1-currentRow[index] }
            
            for columnIndex in (0..<n-1).reversed() {
                if currentRow[columnIndex] != 0 {
                    currentRow[columnIndex] = currentRow[columnIndex+1] + lastRow[columnIndex]   
                }
            }
            lastRow = currentRow
        }
        
        return lastRow[0]
    }
}