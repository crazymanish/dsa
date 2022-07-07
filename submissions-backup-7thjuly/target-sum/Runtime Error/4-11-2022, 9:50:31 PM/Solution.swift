// https://leetcode.com/problems/target-sum

class Solution {
    // Knapsack problem variation - Dynamic Programming
    func findTargetSumWays(_ nums: [Int], _ target: Int) -> Int {
        var totalSum = 0
        for num in nums { totalSum += num }

        // Let's assume total sum was = 5 and target = 3 then we need to find all subsets which equal to 5+3/2 => 4
        // S1+S2 = 5
        // S1-S2 = 3
        // Add both ==> 2S1 = 5+3 :: S1 => 5+3/2
        if (totalSum+target) % 2 != 0 { return 0 } // ODD sum (i.e 11) never Partition
        let knapsackWeight = (totalSum+target)/2

        let numsCount = nums.count
        var dpMatrix: [[Int]] = Array(repeating: Array(repeating: 0, count: (knapsackWeight + 1)), count: numsCount + 1)

        // Set Default value
        for index in 0...nums.count { dpMatrix[index][0] = 1 }
        for index in 1...knapsackWeight { dpMatrix[0][index] = 0 }

        for i in 1...numsCount {
            for j in 0...knapsackWeight {
                let currentNumber = nums[i-1]

                if currentNumber <= j {
                    dpMatrix[i][j] = dpMatrix[i-1][j-currentNumber] + dpMatrix[i-1][j]
                } else {
                    dpMatrix[i][j] = dpMatrix[i-1][j]
                }
            }
        }

        return dpMatrix[numsCount][knapsackWeight]
    }
}