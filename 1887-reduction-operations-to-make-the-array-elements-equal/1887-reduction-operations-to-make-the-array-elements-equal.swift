class Solution {
    func reductionOperations(_ nums: [Int]) -> Int {
        let nums = nums.sorted(by: >)
        var prev: Int = .max
        var result = 0
        
        for i in 0..<nums.count where prev > nums[i] {
            result += i
            prev = nums[i]
        }
        
        return result
    }
}