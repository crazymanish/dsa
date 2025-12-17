/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(n * k)
///     - n = number of days (prices.count)
///     - k = maximum number of completed transactions
///     - For each day, we iterate through all transaction counts (0...k)
///       and update 3 constant states.
///
/// Space Complexity:
///   • O(n * k)
///     - DP table of size [n][3][k+1]
///
/// Problem Model:
///   We allow BOTH long and short positions.
///   A transaction is counted when a position is CLOSED.
///
/// States:
///   dp[day][state][t]:
///     - state = 0 → no open position (empty)
///     - state = 1 → holding a long position
///     - state = 2 → holding a short position
///     - t = number of completed transactions so far
///
/// Goal:
///   End with no open position (state 0) and maximize profit.
/// ---------------------------------------------------------------------------

class Solution {
    func maximumProfit(_ prices: [Int], _ maxTransactions: Int) -> Int {
        let n = prices.count
        guard n > 0, maxTransactions > 0 else { return 0 }
        
        let NEG_INF = Int.min / 2
        
        // dp[day][state][completedTransactions]
        var dp = Array(
            repeating: Array(
                repeating: Array(repeating: NEG_INF, count: maxTransactions + 1),
                count: 3
            ),
            count: n
        )
        
        // Day 0 initialization
        dp[0][0][0] = 0                      // no position
        dp[0][1][0] = -prices[0]             // open long
        dp[0][2][0] = prices[0]              // open short
        
        for day in 1..<n {
            for completed in 0...maxTransactions {
                
                // -----------------------
                // State 0: empty (no open position)
                // -----------------------
                dp[day][0][completed] = dp[day - 1][0][completed] // stay empty
                
                if completed > 0 {
                    // Close a long position
                    dp[day][0][completed] = max(
                        dp[day][0][completed],
                        dp[day - 1][1][completed - 1] + prices[day]
                    )
                    
                    // Close a short position
                    dp[day][0][completed] = max(
                        dp[day][0][completed],
                        dp[day - 1][2][completed - 1] - prices[day]
                    )
                }
                
                // -----------------------
                // State 1: holding a long position
                // -----------------------
                dp[day][1][completed] = dp[day - 1][1][completed] // keep holding long
                dp[day][1][completed] = max(
                    dp[day][1][completed],
                    dp[day - 1][0][completed] - prices[day]       // open long
                )
                
                // -----------------------
                // State 2: holding a short position
                // -----------------------
                dp[day][2][completed] = dp[day - 1][2][completed] // keep holding short
                dp[day][2][completed] = max(
                    dp[day][2][completed],
                    dp[day - 1][0][completed] + prices[day]       // open short
                )
            }
        }
        
        // We must end in state 0 (no open position)
        var bestProfit = 0
        for completed in 0...maxTransactions {
            bestProfit = max(bestProfit, dp[n - 1][0][completed])
        }
        
        return bestProfit
    }
}
