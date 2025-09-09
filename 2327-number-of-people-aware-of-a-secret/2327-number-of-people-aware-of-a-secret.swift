// Time Complexity: O(N)
//   - N: The total number of days.
//   - The algorithm iterates in a single loop from day 2 to N. All operations inside the
//     loop are constant time. This is a significant improvement over the O(N*W) approach.
//
// Space Complexity: O(N)
//   - We still use a DP array of size N+1.
class Solution {
    /**
     * Calculates the number of people who know a secret on the final day using an
     * optimized sliding window approach.
     */
    func peopleAwareOfSecret(_ n: Int, _ delay: Int, _ forget: Int) -> Int {
        let MOD = 1_000_000_007

        // dp[i] = the number of people who *newly* learn the secret on day `i`.
        var newlyAwareOnDay = [Int](repeating: 0, count: n + 1)
        
        // `activeSharers` is our sliding window sum. It tracks the number of people
        // who are currently able to share the secret.
        var activeSharers = 0

        // Base case: On day 1, one person learns the secret.
        newlyAwareOnDay[1] = 1
        
        for day in 2...n {
            // A person who learned on `day - delay` can start sharing today.
            // Add them to our count of active sharers.
            let newlySharingIndex = day - delay
            if newlySharingIndex > 0 {
                activeSharers = (activeSharers + newlyAwareOnDay[newlySharingIndex]) % MOD
            }
            
            // A person who learned on `day - forget` forgets the secret today.
            // Remove them from our count of active sharers.
            let newlyForgettingIndex = day - forget
            if newlyForgettingIndex > 0 {
                // Add MOD before subtracting to prevent negative results.
                activeSharers = (activeSharers - newlyAwareOnDay[newlyForgettingIndex] + MOD) % MOD
            }
            
            // The number of people who learn the secret today is the number of active sharers.
            newlyAwareOnDay[day] = activeSharers
        }
        
        // The final result is the total number of people who still know the secret on day `n`.
        // A person who learned on day `k` knows the secret on day `n` if they haven't forgotten yet.
        // This means `k > n - forget`.
        var totalAware = 0
        let firstDayToCount = n - forget + 1
        for day in firstDayToCount...n {
            totalAware = (totalAware + newlyAwareOnDay[day]) % MOD
        }
        
        return totalAware
    }
}