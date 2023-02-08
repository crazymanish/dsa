class Solution {
    func jump(_ nums: [Int]) -> Int {
        var steps = Array(repeating: nums.count, count: nums.count)
        steps[0] = 0
        
        for i in 0..<nums.count {
            for j in 0...nums[i] where j + i < steps.count {
                steps[j + i] = min(steps[i] + 1, steps[j + i])
            }
        }
        
        return steps.last!
    }
}