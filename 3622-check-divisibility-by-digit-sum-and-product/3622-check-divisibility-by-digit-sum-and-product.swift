class Solution {
    /**
     Problem Summary:
     Determine whether `n` is divisible by the sum of:
     - the sum of its digits
     - the product of its digits

     Strategy:
     Extract each digit using modulo 10.
     While processing the digits, calculate the digit sum and digit product.
     Finally, check whether `n` is divisible by their combined value.

     Time Complexity:
     O(log n), since each digit is processed once.

     Space Complexity:
     O(1), using only a few integer variables.
     */
    func checkDivisibility(_ n: Int) -> Bool {
        var digitSum = 0
        var digitProduct = 1
        var remainingNumber = n

        // Process each digit from right to left.
        while remainingNumber > 0 {
            let digit = remainingNumber % 10

            digitSum += digit
            digitProduct *= digit

            // Remove the processed digit.
            remainingNumber /= 10
        }

        let divisor = digitSum + digitProduct

        return n % divisor == 0
    }
}