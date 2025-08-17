// Time Complexity: O(n)
// The algorithm iterates in a single loop from 1 to `n`. All operations inside the loop
// (addition, subtraction, division) are performed in constant time. Therefore, the overall
// time complexity is linear with respect to `n`.
//
// Space Complexity: O(n)
// The primary data structure is the `dp` array of size `n + 1`. The space required is
// directly proportional to `n`.
class Solution {
    /**
     * Calculates the probability that Alice's score is less than or equal to `n` in the "New 21 Game".
     *
     * - Parameters:
     * - n: The score threshold Alice wants to be at or below.
     * - k: The score at which Alice stops drawing cards.
     * - maxPts: The maximum value of a card drawn (cards are 1...maxPts).
     * - Returns: The probability of Alice's final score being <= n.
     */
    func new21Game(_ n: Int, _ k: Int, _ maxPts: Int) -> Double {
        // --- Edge Case Handling ---
        // If k is 0, Alice starts at 0 and stops immediately. Her score is 0.
        // If n >= 0, the probability is 1.0.
        // Also, Alice stops drawing when her score is between `k` and `k + maxPts - 1`.
        // If n is greater than or equal to this maximum possible score, the probability
        // of her final score being <= n is also 1.0.
        guard k != 0, n < (k + maxPts) else {
            return 1.0
        }
        
        // --- Dynamic Programming Setup ---
        // `dp[i]` will store the probability of having a score of exactly `i`.
        var dp = [Double](repeating: 0.0, count: n + 1)
        
        // Base case: The probability of starting with a score of 0 is 1.
        dp[0] = 1.0
        
        var totalProbability = 0.0
        // `windowSum` stores the sum of probabilities of the last `maxPts` scores
        // from which we can still draw cards (i.e., scores < k).
        var windowSum = 1.0 // Start with the probability of dp[0]
        
        // --- Main DP Loop with Sliding Window ---
        for i in 1...n {
            // The probability of reaching score `i` is the sum of probabilities of
            // the previous `maxPts` scores (the window), divided by the number of possible card values.
            dp[i] = windowSum / Double(maxPts)
            
            if i < k {
                // If we land on a score `i` which is less than `k`, Alice continues to draw.
                // Therefore, the probability `dp[i]` should be added to our sliding window sum
                // to help calculate the probabilities of future scores.
                windowSum += dp[i]
            } else {
                // If we land on a score `i` that is `k` or greater, Alice stops drawing.
                // This is a final score. Since `i <= n`, this is a successful outcome,
                // so we add its probability to our final result.
                totalProbability += dp[i]
            }
            
            // Slide the window: If the score `i - maxPts` is now out of range to reach
            // the next score, subtract its probability from the window sum.
            // We only subtract `dp[i - maxPts]` if `i - maxPts < k`, because probabilities for
            // scores >= k were never added to `windowSum` in the first place.
            // The condition `i - maxPts >= 0` ensures we have a valid index.
            if i - maxPts >= 0 {
                windowSum -= dp[i - maxPts]
            }
        }
        
        return totalProbability
    }
}