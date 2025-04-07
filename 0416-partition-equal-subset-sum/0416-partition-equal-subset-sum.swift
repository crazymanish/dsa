// Using Top-Down approach
// https://www.geeksforgeeks.org/0-1-knapsack-problem-dp-10/
class Solution {
    func canPartition(_ nums: [Int]) -> Bool {
        let totalSum = nums.reduce(0, +) // Calculate the total sum of the numbers

        if totalSum % 2 != 0 { return false } // If the sum is odd, it cannot be partitioned into two equal sums

        let targetSum = totalSum / 2 // The target sum for each subset
        let numsCount = nums.count // Number of elements in the input array

        // dpMatrix[i][j] is true if a subset of the first i elements can sum up to j
        var dpMatrix: [[Bool]] = Array(repeating: Array(repeating: false, count: targetSum + 1), count: numsCount + 1)

        // Initialization:
        // dpMatrix[0][0] is implicitly true (empty subset sums to 0)
        for i in 0...numsCount {
            dpMatrix[i][0] = true // An empty subset can always sum up to 0
        }

        for i in 1...numsCount {
            let currentNumber = nums[i - 1] // Get the current number

            for j in 1...targetSum {
                if currentNumber == j {
                    dpMatrix[i][j] = true // If the current number equals the target, we can form the sum
                } else if currentNumber < j {
                    // We can either include the current number or exclude it
                    dpMatrix[i][j] = dpMatrix[i - 1][j - currentNumber] || dpMatrix[i - 1][j]
                } else {
                    // If the current number is greater than the target, we must exclude it
                    dpMatrix[i][j] = dpMatrix[i - 1][j]
                }
            }
        }

        return dpMatrix[numsCount][targetSum] // Return whether a subset summing up to targetSum is possible
    }
}