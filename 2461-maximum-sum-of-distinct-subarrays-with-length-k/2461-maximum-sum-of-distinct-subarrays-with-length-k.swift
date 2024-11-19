class Solution {
    func maximumSubarraySum(_ nums: [Int], _ k: Int) -> Int {
        var start = 0
        var currentSum = 0
        var maxSum = 0
        var numSet = Set<Int>()

        for end in 0..<nums.count {
            // Adjust window until the current number is distinct
            while numSet.contains(nums[end]) {
                numSet.remove(nums[start])
                currentSum -= nums[start]
                start += 1
            }

            // Add the current number to the window
            numSet.insert(nums[end])
            currentSum += nums[end]

            // Check if the window size is k
            if end - start + 1 == k {
                maxSum = max(maxSum, currentSum)
            
                // Slide the window forward
                numSet.remove(nums[start])
                currentSum -= nums[start]
                start += 1
            }
        }

        return maxSum
    }
}

/*

Approach:
We use the sliding window technique combined with a hash set to maintain distinct elements in the subarray.

Step-by-Step Execution:

1. Initialization:
- Use a sliding window to traverse the array.

Keep track of:
- A Set to store distinct elements in the current window.
- The currentSum of elements in the current window.
- The maxSum found so far.

2. Sliding Window Logic:
- Expand the window by iterating through the array with an end pointer.
- If the element at end is already in the Set (not distinct), shrink the window from the start until the element is removed.
- Add the element at end to the Set and update the currentSum.
- Check if the window size is exactly k. If yes, update maxSum.

3. Edge Cases:
- If k > nums.count, no subarray can satisfy the condition; return 0.


Example Walkthrough:
Input:
let nums = [4, 2, 4, 5, 6]
let k = 3

Execution:

Initial Setup:
start = 0, currentSum = 0, maxSum = 0, numSet = {}

Iteration:

Step 1: Add 4 (at end = 0):
numSet = {4}
currentSum = 4

Step 2: Add 2 (at end = 1):
numSet = {4, 2}
currentSum = 6

Step 3: Add 4 (at end = 2):
numSet contains 4. Shrink window by removing 4 at start = 0.
numSet = {2}
currentSum = 2
Add 4 again:
numSet = {2, 4}
currentSum = 6

Step 4: Add 5 (at end = 3):
numSet = {2, 4, 5}
currentSum = 11
Window size is k, so:
maxSum = max(0, 11) = 11
Slide window by removing 2:
numSet = {4, 5}
currentSum = 9

Step 5: Add 6 (at end = 4):
numSet = {4, 5, 6}
currentSum = 15
Window size is k, so:
maxSum = max(11, 15) = 15
Slide window by removing 4:
numSet = {5, 6}
currentSum = 11

Result:
maxSum = 15

Complexity:
Time Complexity: O(n), as each element is processed at most twice (once added and once removed).
Space Complexity:O(k), for the Set storing up to k elements.
*/