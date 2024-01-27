class Solution {
    func kInversePairs(_ n: Int, _ k: Int) -> Int {
        guard k > 0 else { return 1 } // Base case: Only increasing order works for k = 0.
        guard n > 1 else { return 0 } // Base case: No pairs for n = 1.

        let mod = 1_000_000_007
        var dp = Array(repeating: 0, count: k + 1)
        dp[0] = 1

        // Iterate over the number of elements.
        for i in 2...n {
            let prev = dp

            // The maximum number of pairs is equal to (0 + 1 + ... + i).
            // It's simplified to (i * (i - 1) / 2).
            let maxNumberOfPairs = i * (i - 1) / 2

            // Iterate over the target number of inverse pairs.
            for j in 1...min(k, maxNumberOfPairs) {                
                dp[j] = (dp[j - 1] + prev[j] + (j < i ? 0 : mod - prev[j - i])) % mod
            }
        }

        return dp[k]
    }
}