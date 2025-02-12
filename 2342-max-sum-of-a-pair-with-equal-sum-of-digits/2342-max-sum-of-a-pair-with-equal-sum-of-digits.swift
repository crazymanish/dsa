class Solution {
    func maximumSum(_ nums: [Int]) -> Int {
        // Nested helper function to calculate the sum of digits of a number.
        func sumOfDigits(_ number: Int) -> Int {
            var digitSum = 0
            var mutableNumber = number // Create a mutable copy to avoid modifying the original input
            while mutableNumber > 0 {
                digitSum += mutableNumber % 10 // Extract and add the last digit
                mutableNumber /= 10 // Remove the last digit
            }
            return digitSum
        }

        var maxSum = -1 // Initialize the maximum sum to -1 (no valid pair found yet)

        // Dictionary to store the largest number encountered for each digit sum.
        // Key: Digit sum, Value: Largest number seen so far with that digit sum.
        var largestNumberForDigitSum = [Int: Int]()

        // Iterate through the input array of numbers.
        for number in nums {
            let digitSum = sumOfDigits(number) // Calculate the sum of digits for the current number.

            // Check if we have already seen a number with this digit sum.
            if let largestNumber = largestNumberForDigitSum[digitSum] {
                // If so, update the overall maximum sum if the current pair's sum is larger.
                maxSum = max(maxSum, number + largestNumber)
                // Update the largest number seen for this digit sum if the current number is larger.
                largestNumberForDigitSum[digitSum] = max(largestNumber, number)
            } else {
                // Otherwise, add the current number as the initial largest number for this digit sum.
                largestNumberForDigitSum[digitSum] = number
            }
        }

        return maxSum // Return the overall maximum sum found.
    }
}