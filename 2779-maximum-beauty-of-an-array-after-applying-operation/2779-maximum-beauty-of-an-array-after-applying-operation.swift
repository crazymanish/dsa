class Solution {
    func maximumBeauty(_ nums: [Int], _ k: Int) -> Int {
        let sortedNums = nums.sorted()
        var left = 0
        var maxLength = 0

        for right in 0..<sortedNums.count {
            while sortedNums[right] - sortedNums[left] > 2 * k {
                left += 1
            }
            maxLength = max(maxLength, right - left + 1)
        }

        return maxLength
    }
}

/*
Explanation
Sorting:
- Sort the array nums to make it easier to find subarrays where the difference between the maximum and minimum elements is within the allowed range.

Sliding Window Initialization:
- Initialize two pointers, left and right, to represent the current window. Start both pointers at the beginning of the sorted array.
- Initialize maxLength to 0 to keep track of the maximum length of the valid subarray found.

Iterate with right Pointer:
- Loop through the array with the right pointer.
- For each element at the right pointer, check if the difference between the current element and the element at the left pointer is greater than 2 * k.
- If the difference is greater than 2 * k, increment the left pointer to shrink the window until the difference is within the allowed range.

Update Maximum Length:
- If the current window is valid (difference between the maximum and minimum elements is within 2 * k), update maxLength with the length of the current window (right - left + 1).

Return Result:
- After iterating through the array, return maxLength as the result, which represents the maximum beauty of the array after applying the operation.

This approach ensures that we efficiently find the longest subarray where the difference between the maximum and minimum elements is at most 2 * k.
*/