/**
 * Problem Summary:
 * Given an integer `n`, remove all `0` digits while preserving the order of the
 * remaining digits, compute the sum of the remaining digits, then return:
 *
 *     (number formed after removing zeros) × (sum of remaining digits)
 *
 * Strategy:
 * - Traverse the digits from right to left.
 * - Ignore `0` digits.
 * - Reconstruct the new number using a place-value multiplier.
 * - Simultaneously accumulate the digit sum.
 * - Return the product of the reconstructed number and the digit sum.
 *
 * Time Complexity:
 * O(d), where d is the number of digits in `n`.
 *
 * Space Complexity:
 * O(1)
 */
class Solution {
    func sumAndMultiply(_ n: Int) -> Int {
        var remainingNumber = n
        var numberWithoutZeros = 0
        var digitSum = 0
        var placeValue = 1

        // Process each digit from least significant to most significant.
        while remainingNumber > 0 {
            let digit = remainingNumber % 10

            // Ignore zero digits while rebuilding the number.
            if digit > 0 {
                numberWithoutZeros += digit * placeValue
                digitSum += digit
                placeValue *= 10
            }

            remainingNumber /= 10
        }

        return numberWithoutZeros * digitSum
    }
}