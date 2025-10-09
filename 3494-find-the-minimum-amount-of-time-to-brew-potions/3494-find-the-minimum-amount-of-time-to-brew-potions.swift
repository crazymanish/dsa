// Time Complexity: O(M * S)
// where M is the number of mana values (`mana.count`) and S is the number of skills
// (`skill.count`). The code has an outer loop that runs M times, containing two
// inner loops that each run S times.
//
// Space Complexity: O(S)
// The algorithm uses a dynamic programming array `dp` whose size is proportional
// to the number of skills.
class Solution {
    // NOTE: The function is named `minTime` but uses `max` operations, suggesting
    // the goal is to find a maximum score, not a minimum time.
    func minTime(_ skill: [Int], _ mana: [Int]) -> Int {
        let n = skill.count
        // `dp` array to store the maximum scores. `dp[j]` will hold the optimal
        // score considering some combination of the first `j` skills.
        var dp = Array(repeating: 0, count : n+1)

        // Iterate through each available mana value, treating each as a new stage.
        for i in 0..<mana.count {
            // This variable appears to be unused in the provided code.
            var isDiff = 0

            // === Forward Pass ===
            // This pass updates the DP table from left to right for the current mana value.
            // It calculates a new score at `dp[j+1]` by taking the maximum of either
            // keeping the old value or transitioning from the previous state `dp[j]`,
            // and then adding the gain from the current skill and mana.
            for j in 0..<skill.count {
                dp[j+1] = max(dp[j+1], dp[j]) + skill[j]*mana[i]
            }

            // === Backward Pass ===
            // This pass updates the DP table from right to left. Its specific purpose
            // is tied to the exact problem statement, but it adjusts the scores
            // calculated in the forward pass. This pattern is sometimes used to
            // calculate scores for all possible subarrays or subsequences.
            for j in stride(from: n-1, to: 0, by: -1) {
                dp[j] = dp[j+1] - skill[j]*mana[i]
            }
        }
        
        // The final answer is the maximum score in the DP table after considering all skills and mana values.
        return dp.last!
    }
}