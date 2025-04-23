class Solution {
    func countLargestGroup(_ n: Int) -> Int {
        var digitSumToCount: [Int: Int] = [:] // Dictionary to store the count of numbers for each digit sum

        // Iterate from 1 to n
        for number in 1...n {
            var num = number
            var digitSum = 0

            // Calculate the sum of digits for the current number
            while num > 0 {
                digitSum += num % 10
                num /= 10
            }

            // Increment the count for this digit sum in the dictionary
            digitSumToCount[digitSum, default: 0] += 1
        }

        var largestGroupSize = 0 // Initialize the size of the largest group
        var largestGroupCount = 0 // Initialize the count of groups with the largest size

        // Iterate through the counts of each digit sum
        for groupSize in digitSumToCount.values {
            // If the current group size is larger than the current largest group size
            if groupSize > largestGroupSize {
                largestGroupSize = groupSize // Update the largest group size
                largestGroupCount = 1 // Reset the count of groups with the largest size
            } else if groupSize == largestGroupSize {
                // If the current group size is equal to the largest group size
                largestGroupCount += 1 // Increment the count of groups with the largest size
            }
        }

        return largestGroupCount // Return the number of groups with the largest size
    }
}