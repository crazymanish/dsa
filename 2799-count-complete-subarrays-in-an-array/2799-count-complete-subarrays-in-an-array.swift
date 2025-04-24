class Solution {
    func countCompleteSubarrays(_ nums: [Int]) -> Int {
        let distinctElementCount = Set(nums).count // Count the number of distinct elements in the array
        let arrayLength = nums.count // Store the length of the array for efficiency
        var goodSubarrayCount = 0 // Initialize the count of complete subarrays
        var leftPointer = 0 // Initialize the left pointer of the sliding window
        var elementFrequency = [Int: Int]() // Dictionary to store the frequency of elements in the current window

        // Iterate through the array using the right pointer of the sliding window
        for rightPointer in 0..<arrayLength {
            // Move the right pointer: Add the current element to the window and update its frequency
            elementFrequency[nums[rightPointer], default: 0] += 1

            // Move the left pointer while the current window contains all distinct elements
            while elementFrequency.keys.count == distinctElementCount {
                // The number of complete subarrays ending at rightPointer is the number of possible starting points (from leftPointer to the current rightPointer)
                goodSubarrayCount += (arrayLength - rightPointer)

                // Move the left pointer: Remove the leftmost element from the window and update its frequency
                elementFrequency[nums[leftPointer]]! -= 1
                if elementFrequency[nums[leftPointer]] == 0 {
                    elementFrequency.removeValue(forKey: nums[leftPointer]) // Remove the element from the frequency map if its count becomes zero
                }
                leftPointer += 1
            }
        }

        return goodSubarrayCount // Return the total count of complete subarrays
    }
}