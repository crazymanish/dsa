class Solution {
    func numberOfArrays(_ differences: [Int], _ lowerBound: Int, _ upperBound: Int) -> Int {
        var currentPrefixSum = 0 // Current prefix sum
        var minPrefixSum = 0 // Minimum prefix sum encountered
        var maxPrefixSum = 0 // Maximum prefix sum encountered

        // Iterate through the differences array to find the range of possible prefix sums
        for difference in differences {
            currentPrefixSum += difference // Update the current prefix sum
            minPrefixSum = min(minPrefixSum, currentPrefixSum) // Update the minimum prefix sum
            maxPrefixSum = max(maxPrefixSum, currentPrefixSum) // Update the maximum prefix sum

            // If the range of prefix sums exceeds the allowed range, no valid array is possible
            if maxPrefixSum - minPrefixSum > upperBound - lowerBound {
                return 0
            }
        }

        // Calculate the number of possible starting values for the array
        // The number of valid arrays is the range of possible starting values that keep all prefix sums within bounds
        return (upperBound - lowerBound) - (maxPrefixSum - minPrefixSum) + 1
    }
}