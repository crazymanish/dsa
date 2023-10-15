class Solution {
    func numWays(_ steps: Int, _ arrLen: Int) -> Int {
        guard arrLen > 0, steps > 0 else { return 0 }
        
        // dp[x] means number of unique ways to stop at x
        var dp: [Int] = Array(repeating: 0, count: arrLen)
        dp[0] = 1
        
        for step in 1...steps {
            var previous = 0
            for position in 0...arrLen-1 {
                if position > steps - step {
                    continue
                }
                
                var result = dp[position] + previous
                if position + 1 < arrLen {
                    result += dp[position + 1]
                }
                
                previous = dp[position]
                dp[position] = result % 1000000007
            }
        }
        
        return dp[0]
    }
}