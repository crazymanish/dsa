/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(n), where n = nums.count
///     For each number we update a constant-size DP array.
///
/// Space Complexity:
///   • O(1)
///     Only a fixed-size array of length 3 is used.
///
/// Description:
///   dp[r] = the maximum sum we can obtain such that sum % 3 == r.
///   For each number:
///       We try adding it to all existing dp states and update candidates.
///   The answer is dp[0], which is the max sum divisible by 3.
/// ---------------------------------------------------------------------------
class Solution {
    func maxSumDivThree(_ nums: [Int]) -> Int {
        
        // dp[0] = max sum divisible by 3
        // dp[1] = max sum with remainder 1
        // dp[2] = max sum with remainder 2
        var dp = Array(repeating: 0, count: 3)
        
        for num in nums {
            // Copy current DP state before modifying
            let current = dp
            
            // Try adding this number to each previous remainder class
            for remainder in 0..<3 {
                let newSum = current[remainder] + num
                let newRemainder = newSum % 3
                dp[newRemainder] = max(dp[newRemainder], newSum)
            }
        }
        
        return dp[0]
    }
}
