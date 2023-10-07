class Solution {
    func numOfArrays(_ n: Int, _ m: Int, _ k: Int) -> Int {
        let mod = 1_000_000_007

        // Initialize dp, sum, previousDP, and previousSum with proper dimensions.
        // DP map where the first dimension is maxNum and the second dimension is cost.
        let empty = Array(repeating: Array(repeating: 0, count: k + 1), count: m + 1)
        var dp = empty
        var sum = empty
        var previousDP = empty
        var previousSum = empty

        // Iterate through elements
        for i in 0..<n {
            // Iterate through max numbers and costs
            for maxNum in 1...m {
                // Base case: array has one element and the cost equals to 1.
                if i == 0 {
                    dp[maxNum][1] = 1
                }

                for cost in 1...k {
                    var answer = maxNum * previousDP[maxNum][cost]
                    answer += previousSum[maxNum - 1][cost - 1]
                    dp[maxNum][cost] = (dp[maxNum][cost] + answer) % mod
                    
                    // Update prefix sum.
                    sum[maxNum][cost] = (sum[maxNum - 1][cost] + dp[maxNum][cost]) % mod
                }
            }

            previousDP = dp
            previousSum = sum
            dp = empty
        }

        return sum[m][k]
    }
}