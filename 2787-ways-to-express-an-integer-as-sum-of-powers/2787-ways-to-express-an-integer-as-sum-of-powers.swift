// Time Complexity: O(n * n^(1/x))
//   - Let k be the number of candidate powers. The largest base is roughly n^(1/x), so k is O(n^(1/x)).
//   - Generating these k candidates takes O(k * log x) if using an efficient power function.
//   - The DP calculation involves two nested loops: one iterating through the k candidates,
//     and the other iterating from n down to the candidate value. This results in O(n * k).
//   - The dominant part is the DP calculation, giving a total complexity of O(n * n^(1/x)).
//
// Space Complexity: O(n)
//   - We store the candidate powers, which takes O(n^(1/x)) space.
//   - The DP table `dp` requires O(n) space.
//   - The total space is therefore O(n + n^(1/x)), which simplifies to O(n).
class Solution {
    /**
     * Calculates the number of ways to express `n` as a sum of unique x-th powers.
     *
     * - Parameters:
     * - n: The target integer.
     * - x: The exponent to use.
     * - Returns: The number of ways modulo 1,000,000,007.
     */
    func numberOfWays(_ n: Int, _ x: Int) -> Int {
        let MOD = 1_000_000_007

        // --- Step 1: Generate candidate powers ---
        // Find all unique positive integers `i` such that `i^x <= n`.
        var candidatePowers: [Int] = []
        var i = 1
        while true {
            // Using integer exponentiation to avoid floating point inaccuracies.
            let power = Int(pow(Double(i), Double(x)))
            if power > n { break }
            candidatePowers.append(power)
            i += 1
        }
        
        // --- Step 2: Dynamic Programming ---
        // `dp[i]` will store the number of ways to form the sum `i`.
        var dp = [Int](repeating: 0, count: n + 1)
        
        // Base case: There is one way to make a sum of 0 (by choosing no numbers).
        dp[0] = 1
        
        // For each candidate power, update the ways to form sums.
        for power in candidatePowers {
            // We iterate backwards to ensure each power is used at most once (like a 0/1 knapsack problem).
            // If we iterated forwards, we would be allowing the same power to be used multiple times.
            for targetSum in stride(from: n, through: power, by: -1) {
                // The number of ways to form `targetSum` is increased by the number of ways
                // we could form the remaining sum (`targetSum - power`) before considering the current `power`.
                dp[targetSum] = (dp[targetSum] + dp[targetSum - power]) % MOD
            }
        }
        
        // The final answer is the number of ways to form the sum `n`.
        return dp[n]
    }
}
