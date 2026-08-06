/**
 Problem Summary:
 Find the smallest integer greater than or equal to `n` whose digit product
 is divisible by `t`.

 Strategy:
 Check each number from `n` through `100`. For each number, calculate the
 product of its digits and test whether it is divisible by `t`.

 Time Complexity:
 O(100 - n) × O(log n), which is effectively O(log n) under the constraint.

 Space Complexity:
 O(1)
 */
class Solution {
    func smallestNumber(_ n: Int, _ t: Int) -> Int {
        for candidate in n...100 {
            if digitProduct(of: candidate) % t == 0 {
                return candidate
            }
        }

        return -1
    }

    /// Returns the product of all digits in the given number.
    private func digitProduct(of number: Int) -> Int {
        var remainingNumber = number
        var product = 1

        // `repeat` also handles the number 0 correctly.
        repeat {
            product *= remainingNumber % 10
            remainingNumber /= 10
        } while remainingNumber > 0

        return product
    }
}