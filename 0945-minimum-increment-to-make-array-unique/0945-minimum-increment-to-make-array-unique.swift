class Solution {
    func minIncrementForUnique(_ nums: [Int]) -> Int {
        var nums = nums.sorted()
        
        var answer = 0
        for i in 1..<nums.count where nums[i-1] >= nums[i] {
            answer += nums[i-1] - nums[i] + 1
            nums[i] = nums[i-1] + 1
        }
        
        return answer
    }
}