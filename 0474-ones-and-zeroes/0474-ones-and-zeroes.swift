final class Solution {
    // O(m * n * w) time | O(m * n) space
    // m = available zeroes
    // n = available ones
    // w = number of strings in `strs`
    func findMaxForm(_ strs: [String], _ m: Int, _ n: Int) -> Int {
        // dp[i][j] = max number of strings that can be formed
        // with at most i zeroes and j ones
        var dp = Array(
            repeating: Array(repeating: 0, count: n + 1),
            count: m + 1
        )
        
        // Iterate through each word
        for word in strs {
            let onesCount = word.filter { $0 == "1" }.count
            let zeroesCount = word.filter { $0 == "0" }.count
            
            // Iterate backwards to avoid overwriting results
            // that are needed for the current iteration
            for zeroLimit in stride(from: m, through: zeroesCount, by: -1) {
                for oneLimit in stride(from: n, through: onesCount, by: -1) {
                    dp[zeroLimit][oneLimit] = max(
                        dp[zeroLimit][oneLimit],
                        dp[zeroLimit - zeroesCount][oneLimit - onesCount] + 1
                    )
                }
            }
        }
        
        // dp[m][n] contains the answer: max number of strings that can be formed
        return dp[m][n]
    }
}
