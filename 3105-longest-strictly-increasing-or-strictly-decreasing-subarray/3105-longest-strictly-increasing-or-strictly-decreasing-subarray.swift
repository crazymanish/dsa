class Solution {
    func longestMonotonicSubarray(_ nums: [Int]) -> Int {
        // If the array is empty, return 0
        guard !nums.isEmpty else { return 0 }
        
        // Initialize the maximum length of the subarray
        var maxLength = 1
        // Initialize the current lengths of increasing and decreasing subarrays
        var increasingLength = 1
        var decreasingLength = 1
        
        // Iterate through the array starting from the second element
        for i in 1..<nums.count {
            if nums[i] > nums[i - 1] {
                // If the current element is greater than the previous one,
                // increment the length of the increasing subarray
                increasingLength += 1
                // Reset the length of the decreasing subarray
                decreasingLength = 1
            } else if nums[i] < nums[i - 1] {
                // If the current element is less than the previous one,
                // increment the length of the decreasing subarray
                decreasingLength += 1
                // Reset the length of the increasing subarray
                increasingLength = 1
            } else {
                // If the current element is equal to the previous one,
                // reset both increasing and decreasing subarray lengths
                increasingLength = 1
                decreasingLength = 1
            }
            // Update the maximum length with the maximum value of increasing and decreasing lengths
            maxLength = max(maxLength, increasingLength, decreasingLength)
        }
        
        // Return the maximum length of the monotonic subarray
        return maxLength
    }
}