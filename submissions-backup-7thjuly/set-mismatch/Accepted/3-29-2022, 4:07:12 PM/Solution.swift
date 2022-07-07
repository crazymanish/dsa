// https://leetcode.com/problems/set-mismatch

class Solution {
    func findErrorNums(_ nums: [Int]) -> [Int] {
        var nums = nums
        var duplicate = 0
        var missing = 0
        
        for n in nums {
            if nums[n - 1] < 0 {
                duplicate = n
            } else {
                nums[n - 1] = -1
            }
        }
        
        for i in 0..<nums.count {
            if nums[i] > 0 {
                missing = i + 1
                break   
            }
        }

        return [duplicate, missing]
    }
}