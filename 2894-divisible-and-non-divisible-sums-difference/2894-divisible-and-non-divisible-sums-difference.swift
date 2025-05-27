// Time Complexity: O(n) - The function iterates from 1 to n once.
// Space Complexity: O(1) - The space used is constant, regardless of the input size n.
class Solution {
    func differenceOfSums(_ n: Int, _ m: Int) -> Int {
        // Initialize sumDifference to store the result.
        // This variable will accumulate the sum of numbers not divisible by m
        // and subtract the sum of numbers divisible by m.
        var sumDifference = 0

        // Iterate through numbers from 1 to n (inclusive).
        for number in 1...n {
            // Check if the current number is divisible by m.
            if number % m == 0 {
                // If divisible by m, subtract the number from sumDifference.
                sumDifference -= number
            } else {
                // If not divisible by m, add the number to sumDifference.
                sumDifference += number
            }
        }
        // Return the final calculated difference.
        return sumDifference
    }
}