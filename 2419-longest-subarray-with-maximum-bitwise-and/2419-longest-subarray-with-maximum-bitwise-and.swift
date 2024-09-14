class Solution {
    func longestSubarray(_ nums: [Int]) -> Int {
        let maxNum = nums.max()!
        var (res, currCount) = (1, 0)
        
        for i in nums {
            currCount = i == maxNum ? currCount + 1 : 0
            
            res = max(res, currCount)
        }
        
        return res
    }
}