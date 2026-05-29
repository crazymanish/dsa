class Solution {
    /**
     Problem Summary:
     Given an array of integers, replace each number with the sum of its digits,
     then return the minimum digit sum.

     Strategy:
     Iterate through each number, calculate its digit sum, and keep track of the
     smallest digit sum seen so far.

     Time Complexity:
     O(n * d), where n is the number of elements and d is the number of digits
     in each number.

     Space Complexity:
     O(1), because we do not create an extra array.
     */
    func minElement(_ nums: [Int]) -> Int {
        var minimumDigitSum = Int.max

        for number in nums {
            let currentDigitSum = digitSum(number)
            minimumDigitSum = min(minimumDigitSum, currentDigitSum)
        }

        return minimumDigitSum
    }

    private func digitSum(_ number: Int) -> Int {
        var remainingNumber = number
        var sum = 0

        // Extract each digit from right to left and add it to the sum.
        while remainingNumber > 0 {
            sum += remainingNumber % 10
            remainingNumber /= 10
        }

        return sum
    }
}