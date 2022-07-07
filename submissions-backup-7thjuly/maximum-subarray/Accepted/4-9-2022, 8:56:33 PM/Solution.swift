// https://leetcode.com/problems/maximum-subarray

class Solution {
    func maxSubArray(_ nums: [Int]) -> Int {
        var maxSum = nums[0]
        
        var currentSum = 0
        for num in nums {
            if currentSum < 0 { currentSum = 0 } // Reset if negative sum
            currentSum += num
            
            maxSum = max(maxSum, currentSum)
        }
        
        return maxSum
    }
}