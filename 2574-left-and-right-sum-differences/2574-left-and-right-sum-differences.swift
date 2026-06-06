class Solution {
    /**
     Problem Summary:
     Given an integer array `nums`, return an array where each index contains the
     absolute difference between the sum of elements to its left and the sum of
     elements to its right.

     Strategy:
     - Start with `leftSum = 0`.
     - Start with `rightSum` as the total sum of all elements.
     - For each number:
       - Remove the current number from `rightSum`, because it should not count
         as part of the right side.
       - Compute `abs(leftSum - rightSum)`.
       - Add the current number to `leftSum`, so it counts for future indexes.

     Time Complexity:
     O(n), where n is the number of elements in `nums`.

     Space Complexity:
     O(n), for the result array.
     */
    func leftRightDifference(_ nums: [Int]) -> [Int] {
        var leftSum = 0
        var rightSum = nums.reduce(0, +)
        var differences = [Int]()

        for number in nums {
            // Current number is not part of the right side.
            rightSum -= number

            // Store the absolute difference between left and right sums.
            differences.append(abs(leftSum - rightSum))

            // Current number becomes part of the left side for the next index.
            leftSum += number
        }

        return differences
    }
}