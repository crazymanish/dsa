/**
 Problem Summary:
 Find the maximum product of any two digits in the given number.

 Strategy:
 Convert the number into an array of digits and check every pair.
 Track the largest product found.

 Time Complexity: O(d²), where d is the number of digits.
 Space Complexity: O(d)
 */
class Solution {
    func maxProduct(_ n: Int) -> Int {
        let digits = String(n).compactMap(\.wholeNumberValue)
        var maximumProduct = 0

        // Evaluate every unique pair of digits.
        for firstIndex in 0..<digits.count {
            for secondIndex in (firstIndex + 1)..<digits.count {
                let product = digits[firstIndex] * digits[secondIndex]
                maximumProduct = max(maximumProduct, product)
            }
        }

        return maximumProduct
    }
}