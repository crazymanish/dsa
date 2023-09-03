class Solution {
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        // logic: 
        // Base case: dp[m][0] = dp[0][n] = 1
        // Logic case: dp[i][j] = dp[i-1][j] + dp[i][j-1]
        
        let columns = Array(repeating: 1, count: n)
        var dpMatrix = Array(repeating: columns, count: m)
        
        for row in 1..<m {
            for column in 1..<n {
                dpMatrix[row][column] = dpMatrix[row-1][column] + dpMatrix[row][column-1]
            }
        }
        
        return dpMatrix[m-1][n-1]
    }
}