// https://leetcode.com/problems/running-sum-of-1d-array

class Solution {
    func runningSum(_ nums: [Int]) -> [Int] {
        var output: [Int] = []
        
        for index in 0..<nums.count {
            let previousSum = index == 0 ? 0 : output[index-1]
            let currentSum = previousSum + nums[index]
            
            output.append(currentSum)
        }
        
        return output
    }
}