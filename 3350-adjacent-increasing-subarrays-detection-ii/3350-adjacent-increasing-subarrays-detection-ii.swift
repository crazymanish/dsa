// Time Complexity: O(N)
// The algorithm makes a single pass through the input array `nums`, performing
// constant-time operations at each step.
//
// Space Complexity: O(1)
// The solution uses a fixed number of variables to track state, regardless
// of the input size.
class Solution {
    func maxIncreasingSubarrays(_ nums: [Int]) -> Int {
        // `ans` stores the maximum `k` found so far.
        var ans = 0
        // `length` tracks the length of the current continuous increasing subarray.
        var length = 1
        // `prevLength` tracks the length of the increasing subarray just before the current one.
        var prevLength = 0

        // Iterate through the array to find and evaluate increasing subarrays.
        for r in 1..<nums.count {
            if nums[r] > nums[r-1] {
                // The increasing sequence continues, so increment its length.
                length += 1
            } else {
                // The sequence is broken. The current subarray becomes the "previous" one,
                // and we start a new subarray of length 1.
                prevLength = length
                length = 1
            }
            
            // **Core Logic:** Update the max `k` based on the two main scenarios.
            // 1. `min(prevLength, length)`: Considers two adjacent increasing subarrays.
            //    If their lengths are L1 and L2, we can form two subarrays of length `min(L1, L2)`.
            //    For example, with [1,5] and [2,3,4], we can take [1,5] and [2,3] (k=2).
            // 2. `length / 2`: Considers splitting one long subarray.
            //    If a single subarray has length L, we can split it into two non-overlapping
            //    subarrays of length `L / 2`. E.g., [1,2,3,4,5] can give [1,2] and [3,4] (k=2).
            ans = max(ans, min(prevLength, length), length / 2)
        }
        return ans
    }
}