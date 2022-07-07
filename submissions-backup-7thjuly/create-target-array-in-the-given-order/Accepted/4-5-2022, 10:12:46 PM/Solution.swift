// https://leetcode.com/problems/create-target-array-in-the-given-order

class Solution {
    func createTargetArray(_ nums: [Int], _ index: [Int]) -> [Int] {
        let numsCount = nums.count
        var targetArray: [Int] = []
        
        var i = 0
        while i < numsCount {
            let numIndex = index[i]
            let numVal = nums[i]
            
            targetArray.insert(numVal, at: numIndex)
            
            i += 1
        }
        
        return targetArray
    }
}