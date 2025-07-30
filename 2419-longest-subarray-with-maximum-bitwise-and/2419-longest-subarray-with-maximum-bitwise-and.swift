// Time Complexity: O(N)
// The algorithm makes two passes over the input array: one to find the
// maximum value and a second to find the longest streak of that value.
//
// Space Complexity: O(1)
// The solution uses a constant amount of extra space for variables,
// regardless of the input size.
class Solution {
    /// Finds the length of the longest contiguous subarray consisting only of the maximum element in the array.
    func longestSubarray(_ nums: [Int]) -> Int {
        // A guard for an empty input array, though problem constraints usually prevent this.
        guard let maxValue = nums.max() else { return 0 }

        var maxLength = 0
        var currentStreak = 0
        
        // Iterate through the array to find the longest streak of the maxValue.
        for num in nums {
            if num == maxValue {
                // If we find the max value, extend the current streak.
                currentStreak += 1
            } else {
                // Otherwise, the streak is broken; reset the counter.
                currentStreak = 0
            }
            
            // Update the overall maximum length found so far.
            maxLength = max(maxLength, currentStreak)
        }
        
        return maxLength
    }
}