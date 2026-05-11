class Solution {
    /**
     Problem Summary:
     Given an array of integers, return a new array containing each digit of every number
     in the same left-to-right order as the original input.

     Strategy:
     Traverse the input array from right to left. For each number, extract its digits from
     right to left using modulo and division, then reverse the collected result at the end
     to restore the correct order.

     Time Complexity:
     O(d), where d is the total number of digits across all numbers.

     Space Complexity:
     O(d), for storing the separated digits.
     */
    func separateDigits(_ nums: [Int]) -> [Int] {
        var separatedDigits: [Int] = []

        // Traverse from the end so digits can be collected in reverse order.
        for numberIndex in (0..<nums.count).reversed() {
            var currentNumber = nums[numberIndex]

            // Extract digits from right to left.
            while currentNumber != 0 {
                let digit = currentNumber % 10
                separatedDigits.append(digit)

                currentNumber /= 10
            }
        }

        // Reverse once at the end to restore the original left-to-right digit order.
        return Array(separatedDigits.reversed())
    }
}