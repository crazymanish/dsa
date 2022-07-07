// https://leetcode.com/problems/maximum-absolute-sum-of-any-subarray

class Solution {
    func maxAbsoluteSum(_ nums: [Int]) -> Int {
        let maxSum = findMaxSum(nums)
        let minSum = findMinSum(nums)
        
        return max(abs(maxSum), abs(minSum))
    }
    
    // kadane's algorithm
    private func findMaxSum(_ nums: [Int]) -> Int {
        var maxSum = nums[0]
        var currentSum = 0
        
        for num in nums {
            currentSum += num
            
            maxSum = max(maxSum, currentSum)
            
            if currentSum < 0 { currentSum = 0 }
        }
        
        return maxSum
    }
    
    // kadane's algorithm
    private func findMinSum(_ nums: [Int]) -> Int {
        var minSum = nums[0]
        var currentSum = 0
        
        for num in nums {
            currentSum += num
            
            minSum = min(minSum, currentSum)
            
            if currentSum > 0 { currentSum = 0 }
        }
        
        return minSum
    }
}