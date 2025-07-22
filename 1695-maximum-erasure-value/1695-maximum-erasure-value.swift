/*
Time Complexity: O(N)
- The algorithm uses a sliding window approach with two pointers, left and right.
- Each element in the input array is visited at most once by the right pointer and at most once by the left pointer. This results in a linear time complexity.

Space Complexity: O(K)
- The space required is determined by the dictionary (lastSeenAt), which stores the most recent index of each unique number.
- In the worst case, where all elements are unique, the space complexity is O(N). If there are K unique numbers, it's O(K). This is an improvement over the original solution's O(N) space for both the dictionary and the prefix sum array.
*/
class Solution {
    /// Finds the maximum sum of a contiguous subarray with unique elements.
    func maximumUniqueSubarray(_ nums: [Int]) -> Int {
        var maxSum = 0
        var currentSum = 0
        
        // The left boundary of our sliding window.
        var left = 0
        
        // A dictionary to store the last seen index of each number.
        // [Number: Index]
        var lastSeenAt: [Int: Int] = [:]

        for right in 0..<nums.count {
            let currentNum = nums[right]
            
            // If the current number is a duplicate within our window,
            // shrink the window from the left until the old duplicate is removed.
            if let duplicateIndex = lastSeenAt[currentNum], duplicateIndex >= left {
                // Remove all elements from the old `left` up to the `duplicateIndex`.
                for i in left...duplicateIndex {
                    currentSum -= nums[i]
                }
                // Slide the window's left boundary forward.
                left = duplicateIndex + 1
            }

            // Add the current number to the window's sum.
            currentSum += currentNum
            
            // Update the last seen index for the current number.
            lastSeenAt[currentNum] = right
            
            // Check if the current window's sum is the new maximum.
            maxSum = max(maxSum, currentSum)
        }
        
        return maxSum
    }
}

/*
Explanation of the Logic \U0001f5bc️
This problem is a perfect fit for the sliding window algorithm. Imagine a window that slides across the array from left to right. We want to find the "best" window, which in this case is the one with unique elements that has the largest sum.

The Window: We use two pointers, left and right, to define our current subarray (the window). This window [left...right] will always contain unique elements.

Expanding: The right pointer moves forward one step at a time, expanding the window. The new element nums[right] is added to a currentSum.

Shrinking: Before adding nums[right], we check if it already exists within our current window ([left...right]). We use a dictionary lastSeenAt to do this check in constant time.

If nums[right] is a duplicate (meaning we've seen it before at an index duplicateIndex which is inside our current window), we must shrink the window from the left.

We move the left pointer forward to duplicateIndex + 1, subtracting the values of the elements we pass from currentSum. This ensures the window is once again free of duplicates.

Tracking the Max Sum: After every expansion of the window, the currentSum represents the sum of a valid unique subarray. We compare it with maxSum and update maxSum if our current window's sum is larger.

This process ensures we check every possible unique subarray efficiently and find the one with the maximum sum.
*/