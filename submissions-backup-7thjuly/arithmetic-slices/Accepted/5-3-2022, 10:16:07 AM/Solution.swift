// https://leetcode.com/problems/arithmetic-slices

class Solution {
    func numberOfArithmeticSlices(_ nums: [Int]) -> Int {
        let numsCount = nums.count
        
        guard numsCount > 2 else { return 0 }
        
        var dpCache: [Int] = []
        dpCache.append(0)
        
        for index in 2..<numsCount {
            let diff1 = nums[index] - nums[index-1]
            let diff2 = nums[index-1] - nums[index-2]
            
            if diff1 == diff2 {
                let newCount = 1 + dpCache.last!
                dpCache.append(newCount)
            } else {
                dpCache.append(0)
            }
        }
        
        var output = 0
        for value in dpCache { output += value }
        
        return output
    }
}