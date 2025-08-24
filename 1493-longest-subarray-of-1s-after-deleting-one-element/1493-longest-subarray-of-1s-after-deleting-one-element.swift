// Time Complexity: O(N)
//   - N: The number of elements in the `nums` array.
//   - This is a single-pass sliding window solution. Both the `right` pointer (in the `for` loop)
//     and the `left` pointer (in the `while` loop) traverse the array at most once from
//     left to right. Therefore, the time complexity is linear.
//
// Space Complexity: O(1)
//   - The solution uses a fixed number of variables (`left`, `zeroCount`, `maxLength`)
//     to maintain the state of the sliding window. The space required is constant and does
//     not scale with the input size.
class Solution {
    /**
     * Finds the length of the longest subarray of 1s after deleting exactly one element.
     *
     * This problem can be efficiently solved using a sliding window approach. The goal is to
     * find the longest possible window in the array that contains at most one zero.
     *
     * The window is defined by a `left` and `right` pointer. We expand the window by moving
     * `right`. If the window becomes "invalid" (contains more than one zero), we shrink it
     * by moving `left` until it becomes valid again. The length of the subarray of ones
     * for a valid window of size `S` is `S - 1` (to account for the single deleted zero).
     *
     * - Parameter nums: A binary array of 0s and 1s.
     * - Returns: The length of the longest subarray of 1s after one deletion.
     */
    func longestSubarray(_ nums: [Int]) -> Int {
        var maxLength = 0
        var left = 0 // The left boundary of our sliding window
        var zeroCount = 0 // The number of zeros within the current window [left...right]

        // `right` pointer expands the window to the right
        for right in 0..<nums.count {
            // If the new element entering the window is a zero, increment our count.
            if nums[right] == 0 {
                zeroCount += 1
            }
            
            // Shrink the window from the left until it is valid again.
            // A window is invalid if it contains more than one zero.
            while zeroCount > 1 {
                // If the element leaving the window is a zero, decrement our count.
                if nums[left] == 0 {
                    zeroCount -= 1
                }
                // Slide the left boundary to the right.
                left += 1
            }
            
            // After ensuring the window is valid, calculate the length of the subarray of ones.
            // The window size is `right - left + 1`. Since we must delete one element
            // (the one zero in our window), the length of the ones is `window size - 1`.
            // This simplifies to `right - left`.
            maxLength = max(maxLength, right - left)
        }
        
        // The problem states we *must* delete one element. If the maxLength equals the
        // original array's count, it means the array consisted of all ones. In this case,
        // the result must be one less than the array length. The `right - left` calculation
        // already handles this case correctly. For an all-1s array, `zeroCount` never
        // exceeds 0, `left` stays at 0, and `maxLength` becomes `(nums.count - 1) - 0`.
        return maxLength
    }
}