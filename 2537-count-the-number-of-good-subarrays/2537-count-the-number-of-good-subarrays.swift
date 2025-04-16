class Solution {
    func countGood(_ nums: [Int], _ k: Int) -> Int {
        let arrayLength = nums.count // Store the length of the array for clarity

        var leftPointer = 0 // Initialize the left pointer of the sliding window
        var elementFrequency: [Int: Int] = [:] // Dictionary to store the frequency of each element
        var currentPairCount = 0 // Initialize the count of pairs in the current window
        var goodSubarrayCount = 0 // Initialize the count of good subarrays

        // Iterate through the array using the right pointer of the sliding window
        for rightPointer in 0..<arrayLength {
            // Move the right pointer: Add the current element to the window
            currentPairCount += elementFrequency[nums[rightPointer], default: 0] // Add the number of pairs formed with the current element
            elementFrequency[nums[rightPointer], default: 0] += 1 // Increment the frequency of the current element

            // Move the left pointer while the window still has at least k pairs
            while currentPairCount - (elementFrequency[nums[leftPointer], default: 0] - 1) >= k {
                let previousFrequency = elementFrequency[nums[leftPointer], default: 0] // Store the previous frequency of the leftmost element
                currentPairCount -= previousFrequency - 1 // Subtract the number of pairs that will be lost when removing the leftmost element
                elementFrequency[nums[leftPointer], default: 0] -= 1 // Decrement the frequency of the leftmost element
                leftPointer += 1 // Move the left pointer to the right
            }

            // If the current window has at least k pairs, count it as a good subarray
            if currentPairCount >= k {
                goodSubarrayCount += leftPointer + 1 // Add the number of subarrays ending at the right pointer
            }
        }

        return goodSubarrayCount // Return the total count of good subarrays
    }
}