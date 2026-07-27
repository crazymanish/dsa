/**
 Problem Summary:
 Find the maximum product of two numbers after subtracting 1 from each.

 Strategy:
 Track the two largest numbers in one pass. Since the input values are
 positive, the two largest values produce the maximum product.

 Time Complexity: O(n)
 Space Complexity: O(1)
 */
class Solution {
    func maxProduct(_ nums: [Int]) -> Int {
        var largest = Int.min
        var secondLargest = Int.min

        for number in nums {
            if number >= largest {
                // Shift the current largest value into second place.
                secondLargest = largest
                largest = number
            } else if number > secondLargest {
                // Update the second-largest value when appropriate.
                secondLargest = number
            }
        }

        return (largest - 1) * (secondLargest - 1)
    }
}