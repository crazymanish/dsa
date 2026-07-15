class Solution {
    /**
     Problem Summary:
     Calculate the greatest common divisor of:
     - The sum of the first `n` odd numbers.
     - The sum of the first `n` even numbers.

     Strategy:
     Use the mathematical formulas:
     - Sum of the first `n` odd numbers: `n²`
     - Sum of the first `n` even numbers: `n × (n + 1)`

     Then apply the iterative Euclidean algorithm to find their GCD.

     Time Complexity:
     O(log n), due to the Euclidean algorithm.

     Space Complexity:
     O(1), as only a constant amount of extra space is used.
     */
    func gcdOfOddEvenSums(_ n: Int) -> Int {
        let oddNumbersSum = n * n
        let evenNumbersSum = n * (n + 1)

        return greatestCommonDivisor(oddNumbersSum, evenNumbersSum)
    }

    /// Computes the GCD using the iterative Euclidean algorithm.
    private func greatestCommonDivisor(_ firstNumber: Int, _ secondNumber: Int) -> Int {
        var currentNumber = firstNumber
        var remainder = secondNumber

        while remainder != 0 {
            let previousRemainder = remainder
            remainder = currentNumber % remainder
            currentNumber = previousRemainder
        }

        return currentNumber
    }
}