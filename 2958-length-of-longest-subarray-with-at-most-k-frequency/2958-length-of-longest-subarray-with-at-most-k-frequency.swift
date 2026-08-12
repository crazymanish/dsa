/**
 Problem Summary:
 Find the length of the longest contiguous subarray where no number
 appears more than `k` times.

 Strategy:
 Use a sliding window with two pointers. Expand the window by moving
 `right`. If the frequency of the newly added number exceeds `k`,
 move `left` forward until the window becomes valid again.

 Time Complexity: O(n)
 Space Complexity: O(n)
 */
class Solution {
    func maxSubarrayLength(_ nums: [Int], _ k: Int) -> Int {
        var leftIndex = 0
        var longestLength = 0
        var frequencies: [Int: Int] = [:]

        for rightIndex in nums.indices {
            let currentNumber = nums[rightIndex]
            frequencies[currentNumber, default: 0] += 1

            // Shrink the window while the current number appears too often.
            while frequencies[currentNumber, default: 0] > k {
                let leftNumber = nums[leftIndex]
                frequencies[leftNumber, default: 0] -= 1
                leftIndex += 1
            }

            // The window [leftIndex...rightIndex] is valid.
            longestLength = max(
                longestLength,
                rightIndex - leftIndex + 1
            )
        }

        return longestLength
    }
}