/**
 Problem Summary:
 Find the greatest common divisor (GCD) of the smallest and largest values
 in the array.

 Strategy:
 The GCD of all array elements is equal to the GCD of the minimum and maximum
 elements. Sort the array to identify those values, then use Euclid's algorithm.

 Time Complexity: O(n log n)
 Space Complexity: O(n)
 */
class Solution {
    func findGCD(_ nums: [Int]) -> Int {
        let sortedNumbers = nums.sorted()
        let smallestNumber = sortedNumbers[0]
        let largestNumber = sortedNumbers[sortedNumbers.count - 1]

        return gcd(smallestNumber, largestNumber)
    }

    // Repeatedly replace (a, b) with (b, a % b) until b becomes zero.
    private func gcd(_ first: Int, _ second: Int) -> Int {
        var first = first
        var second = second

        while second != 0 {
            let remainder = first % second
            first = second
            second = remainder
        }

        return first
    }
}