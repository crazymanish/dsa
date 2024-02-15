class Solution {
    func largestPerimeter(_ nums: [Int]) -> Int {
        let nums = nums.sorted(by: >)
        var sum = nums.reduce(0, +)
        
        for num in nums {
            sum -= num
            
            if sum > num { return sum + num }
        }
        
        return -1
    }
}