class Solution {
    func numTilings(_ n: Int) -> Int {
        if n <= 2 { return n }
        
        let modNum = 1000000007
        var dp = Array(repeating: Array(repeating: 0, count: 2), count: n + 1)
        dp[1][0] = 1
        dp[2][0] = 2
        dp[2][1] = 1
        
        for i in 3...n {
            dp[i][0] = dp[i-1][0] % modNum
            dp[i][0] = (dp[i][0] + dp[i-2][0]) % modNum
            dp[i][0] = (dp[i][0] + dp[i-1][1]) % modNum
            dp[i][0] = (dp[i][0] + dp[i-1][1]) % modNum
            dp[i][1] = dp[i-2][0] % modNum
            dp[i][1] = (dp[i][1] + dp[i-1][1]) % modNum
        }
        
        return dp[n][0] % modNum
    }
}