class Solution {
    func maxSumAfterPartitioning(_ arr: [Int], _ k: Int) -> Int {
        let n = arr.count
        var dp = [Int](repeating: 0, count: n+1)

        for i in 1...n {
            var currentMax = 0

            for j in 1...min(k, i) {
                currentMax = max(currentMax, arr[i-j])
                dp[i] = max(dp[i], dp[i-j] + currentMax*j)
            }
        }

        return dp[n]
    }
}