//for example, input: [[0, 0, 0, 0, 0, 0],[0, 0, 1, 0, 0, 0], [0, 0, 0, 0, 0, 0]]

//0, 1, 0, 0, 0, 0, 0 
//0, 1, 1, 1, 1, 1, 1
//0, 1, 2, 0, 1, 2, 3
//0, 1, 3, 3, 4, 6, 9

class Solution {
    func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
        var rows = obstacleGrid.count
        var columns = obstacleGrid[0].count
        var dp = Array(repeating: Array(repeating: 0, count: columns + 1), count: rows + 1)
        
        dp[0][1] = 1 // start point
        
        for row in 1...rows {
            for column in 1...columns {
                if obstacleGrid[row-1][column-1] != 1 {
                    dp[row][column] = dp[row-1][column] + dp[row][column-1]
                }
            }
        }
        
        return dp[rows][columns]
    }
}