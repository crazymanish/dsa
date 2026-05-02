class Solution {
    /**
     Problem Summary:
     Count how many numbers from 1 to n are "good" after rotation.
     A number is "good" if:
     - It contains no invalid digits (3, 4, 7)
     - It contains at least one digit that changes after rotation (2, 5, 6, 9)

     Strategy:
     - Iterate through each number from 1 to n
     - Use a helper function to validate each number digit by digit

     Time Complexity:
     O(n * d) where d = number of digits in n

     Space Complexity:
     O(1)
     */

    func rotatedDigits(_ n: Int) -> Int {
        var goodNumberCount = 0

        // Helper function to determine if a number is "good"
        func isGoodNumber(_ number: Int) -> Bool {
            let invalidDigits: Set<Int> = [3, 4, 7]      // Digits that invalidate the number
            let changingDigits: Set<Int> = [2, 5, 6, 9]  // Digits that change after rotation

            var remaining = number
            var hasChangedDigit = false  // Tracks if at least one digit changes

            // Process each digit from right to left
            while remaining > 0 {
                let currentDigit = remaining % 10

                // If any digit is invalid → entire number is invalid
                if invalidDigits.contains(currentDigit) {
                    return false
                }

                // Check if this digit changes after rotation
                if changingDigits.contains(currentDigit) {
                    hasChangedDigit = true
                }

                // Move to the next digit
                remaining /= 10
            }

            // Valid only if at least one digit changes
            return hasChangedDigit
        }

        // Check every number in range
        for currentNumber in 1...n {
            if isGoodNumber(currentNumber) {
                goodNumberCount += 1
            }
        }

        return goodNumberCount
    }
}