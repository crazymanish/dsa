// Time Complexity: O(N)
// The algorithm makes a single pass through the input array `nums`, performing
// constant-time operations at each step.
//
// Space Complexity: O(N)
// A dynamic programming array `dp` of the same size as the input array is used to
// store intermediate results.
class Solution {
    /// Checks if the array contains at least two non-overlapping increasing subarrays of length k.
    func hasIncreasingSubarrays(_ nums: [Int], _ k: Int) -> Bool {
        // Edge case: An increasing subarray of length 1 is just a single number.
        // It's always possible to find two non-overlapping single numbers, so this is true.
        guard k > 1 else { return true }
        
        // `dp[i]` stores the length of the continuous increasing subarray ending at index `i`.
        // Every element is an increasing subarray of length 1 by itself.
        var dp = Array(repeating: 1, count: nums.count)
        
        // Iterate through the array starting from the second element.
        for i in 1..<nums.count {
            // If the current number is greater than the previous one, the increasing sequence continues.
            if nums[i] > nums[i-1] {
                dp[i] = dp[i-1] + 1
            }
            // Otherwise, the sequence is broken, and dp[i] remains 1.

            // **Core Logic:** Check if we have found two valid subarrays.
            // We check if an increasing subarray of length k ends at the current index `i` AND
            // if another one ended `k` positions earlier, at index `i - k`.
            // This `i - k` separation guarantees the two subarrays are non-overlapping.
            if i - k >= 0 && dp[i] >= k && dp[i - k] >= k {
                return true
            }
        }

        // If the loop completes without finding such a pair, none exists.
        return false
    }
}