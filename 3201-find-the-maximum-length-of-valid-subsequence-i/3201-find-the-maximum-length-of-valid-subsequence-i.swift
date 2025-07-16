/*
Time Complexity: O(n), where n is the number of elements in the input array nums. This is because we iterate through the array once.
Space Complexity: O(1), as we only use a few extra variables to store counts, regardless of the input size.
*/
class Solution {
    /// Finds the maximum length of a subsequence that is all-even, all-odd, or has alternating parity.
    func maximumLength(_ nums: [Int]) -> Int {
        // Count of elements in the longest subsequence with alternating parity.
        var alternatingLength = 0
        // Total count of odd numbers.
        var oddCount = 0
        // Total count of even numbers.
        var evenCount = 0

        // Stores the parity (0 for even, 1 for odd) of the last element added to the alternating subsequence.
        // -1 indicates the subsequence is empty.
        var lastParity = -1

        for num in nums {
            let currentParity = num % 2

            // Increment the total counts for even and odd numbers.
            if currentParity == 0 {
                evenCount += 1
            } else {
                oddCount += 1
            }

            // If the current number's parity is different from the last one,
            // it can extend the alternating subsequence.
            if lastParity == -1 || lastParity != currentParity {
                alternatingLength += 1
                lastParity = currentParity
            }
        }
        
        // The result is the maximum length among the three possible subsequence types:
        // 1. All even numbers.
        // 2. All odd numbers.
        // 3. Alternating parity numbers.
        return max(alternatingLength, oddCount, evenCount)
    }
}