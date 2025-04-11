class Solution {
    func countSymmetricIntegers(_ low: Int, _ high: Int) -> Int {
        var symmetricCount = 0 // Initialize the count of symmetric integers

        // Iterate through all numbers in the given range
        for currentNumber in low...high {
            let numberString = String(currentNumber) // Convert the number to a string
            let digitCount = numberString.count // Get the number of digits

            // Check if the number has an even number of digits (a necessary condition for symmetry)
            if digitCount.isMultiple(of: 2) {
                let middleIndex = digitCount / 2 // Calculate the middle index
                let digits = numberString.compactMap { $0.wholeNumberValue } // Convert string digits to an array of integers

                // Calculate the sum of the digits in the left half
                let leftDigitSum = digits[0..<middleIndex].reduce(0, +)

                // Calculate the sum of the digits in the right half
                let rightDigitSum = digits[middleIndex..<digitCount].reduce(0, +)

                // If the sums are equal, increment the count of symmetric integers
                if leftDigitSum == rightDigitSum {
                    symmetricCount += 1
                }
            }
        }

        return symmetricCount // Return the total count of symmetric integers
    }
}