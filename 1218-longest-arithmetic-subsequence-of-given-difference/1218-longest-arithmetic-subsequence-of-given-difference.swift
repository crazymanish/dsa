class Solution {
    func longestSubsequence(_ arr: [Int], _ difference: Int) -> Int {
        var dp = [Int](repeating: 0, count: arr.count)
        var dict = [Int: Int]()
        let lastIndex = arr.count-1
        dp[lastIndex] = 1
        dict[arr[lastIndex]] = 1

        var result = 1

        for index in (0..<dp.count-1).reversed() {
            var oldValue = dict[arr[index] + difference] ?? 0
            dp[index] = 1 + oldValue
            dict[arr[index]] = dp[index]
            
            result = max(result, dp[index])
        }

        return result
    }
}