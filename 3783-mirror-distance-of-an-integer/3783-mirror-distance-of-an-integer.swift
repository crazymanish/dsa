class Solution {
    /**
     Problem Summary:
     Given an integer `n`, compute the absolute difference between the number
     and its digit-reversed counterpart.

     Example:
     n = 123 → reversed = 321 → result = |123 - 321| = 198

     Strategy:
     - Reverse the digits of the number using modulo and division.
     - Compute the absolute difference between the original and reversed number.

     Time Complexity:
     O(d), where d is the number of digits in `n`.

     Space Complexity:
     O(1), constant extra space.
     */

    func mirrorDistance(_ number: Int) -> Int {
        return abs(number - reverseNumber(number))
    }

    /// Reverses the digits of a given integer.
    private func reverseNumber(_ value: Int) -> Int {
        var remaining = value
        var reversedValue = 0

        while remaining > 0 {
            // Extract last digit and append it to reversedValue
            reversedValue = reversedValue * 10 + remaining % 10

            // Remove last digit from remaining
            remaining /= 10
        }

        return reversedValue
    }
}