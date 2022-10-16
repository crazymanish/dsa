class Solution {
    func minDifficulty(_ jobDifficulty: [Int], _ d: Int) -> Int {
        guard jobDifficulty.count >= d else { return -1}
        guard jobDifficulty.count > 1 else { return jobDifficulty[0] }
        
        let dpRow = Array(repeating: Int.max, count: d)
        var dp = Array(repeating: dpRow, count: jobDifficulty.count)
        dp[0][0] = jobDifficulty[0]
        
        for i in 1..<jobDifficulty.count {
            let minD = max(0, d - jobDifficulty.count + i)
            let maxD = min(d - 1, i)
            
            for j in minD...maxD {
                if j == 0 {
                    dp[i][j] = max(dp[i - 1][j], jobDifficulty[i])
                    continue
                }
                
                var maxDifficulty = 0
                for k in stride(from: i, through: j, by: -1) {
                    maxDifficulty = max(maxDifficulty, jobDifficulty[k])
                    dp[i][j] = min(dp[i][j], dp[k - 1][j - 1] + maxDifficulty)
                }
            }
        }
        
        return dp[jobDifficulty.count - 1][d - 1]
    }
}