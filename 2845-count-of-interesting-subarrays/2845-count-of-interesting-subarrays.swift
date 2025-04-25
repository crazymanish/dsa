class Solution {
    func countInterestingSubarrays(_ nums: [Int], _ modulo: Int, _ k: Int) -> Int {
        let arrayLength = nums.count // Store the length of the input array
        var goodSubarrayCount = 0 // Initialize the count of interesting subarrays
        var currentRemainderCount = 0 // Keep track of the count of elements with remainder k in the current subarray
        var remainderFrequency: [Int: Int] = [0: 1] // Dictionary to store the frequency of prefix remainders

        // Iterate through the array using the right pointer of a conceptual sliding window
        for rightPointer in 0..<arrayLength {
            // If the current element's remainder when divided by modulo is k, increment the remainder count
            if nums[rightPointer] % modulo == k {
                currentRemainderCount = (currentRemainderCount + 1) % modulo
            }

            // Calculate the required remainder to form an interesting subarray ending at rightPointer
            // An interesting subarray has a remainder of 0 when the count of elements with remainder k is taken modulo modulo
            let requiredRemainder = (modulo + currentRemainderCount - k) % modulo

            // The number of interesting subarrays ending at rightPointer is the frequency of the required remainder encountered so far
            goodSubarrayCount += remainderFrequency[requiredRemainder, default: 0]

            // Update the frequency of the current remainder count
            remainderFrequency[currentRemainderCount, default: 0] += 1
        }

        return goodSubarrayCount // Return the total count of interesting subarrays
    }
}