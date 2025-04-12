class Solution {
    func countGoodIntegers(_ n: Int, _ k: Int) -> Int {
        let halfLength = (n + 1) / 2 // Calculate the length of one half of the palindrome
        let minHalfValue = Int(pow(10.0, Double(halfLength - 1))) // Minimum possible value for the half
        let maxHalfValue = Int(pow(10.0, Double(halfLength))) // Maximum possible value for the half
        var goodIntegerCount = 0 // Initialize the count of good integers
        var seenDigitCounts = Set<String>() // Set to track unique digit counts to avoid duplicates

        // Nested helper function to calculate factorial
        func factorial(_ number: Int) -> Int {
            return (1...max(number, 1)).reduce(1, *)
        }

        // Iterate through possible values for the first half of the palindrome
        for halfValue in minHalfValue..<maxHalfValue {
            let palindrome = String(halfValue) + String(String(halfValue).reversed()).dropFirst(n % 2) // Construct the palindrome
            let sortedPalindromeDigits = String(palindrome.sorted()) // Sort the digits of the palindrome

            // Skip if the palindrome is not divisible by k or if we've seen this digit combination before
            if Int(palindrome)! % k != 0 || seenDigitCounts.contains(sortedPalindromeDigits) { continue }

            seenDigitCounts.insert(sortedPalindromeDigits) // Add the sorted digits to the set
            var digitCounts = [Character: Int]() // Dictionary to store the count of each digit in the palindrome

            // Count the occurrences of each digit in the palindrome
            for digit in palindrome {
                digitCounts[digit, default: 0] += 1
            }

            // Calculate the number of permutations of the palindrome
            let firstDigitChoices = n - (digitCounts["0"] ?? 0) // Number of choices for the first digit (cannot be 0 if 0 is present)
            var permutations = firstDigitChoices * factorial(n - 1) // Total permutations

            // Adjust permutations for duplicate digits
            for frequency in digitCounts.values {
                permutations /= factorial(frequency)
            }

            goodIntegerCount += permutations // Add the number of permutations to the total count
        }

        return goodIntegerCount // Return the total count of good integers
    }
}