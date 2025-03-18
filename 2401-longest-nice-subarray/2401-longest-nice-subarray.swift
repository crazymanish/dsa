class Solution {
    func longestNiceSubarray(_ nums: [Int]) -> Int {
        var left = 0 // Left pointer of the sliding window
        var currentAnd = 0 // Bitwise AND of the current subarray
        var maxLength = 0 // Maximum length of a nice subarray

        for right in 0..<nums.count {
            // While the current bitwise AND is not 0, shrink the window
            while (currentAnd & nums[right]) != 0 {
                currentAnd ^= nums[left] // Remove the leftmost element from the current AND
                left += 1 // Move the left pointer to the right
            }

            currentAnd |= nums[right] // Add the current element to the current AND
            maxLength = max(maxLength, right - left + 1) // Update the maximum length
        }

        return maxLength
    }
}