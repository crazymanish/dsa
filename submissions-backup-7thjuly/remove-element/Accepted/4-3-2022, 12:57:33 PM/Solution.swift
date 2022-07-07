// https://leetcode.com/problems/remove-element

class Solution {
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        // Just shift elements that are not eqaul to "val" to left-most
        
        var leftIndexToShift = 0 
        for index in 0..<nums.count {
            let currentIndexValue = nums[index]
            
            if currentIndexValue != val {
                nums[leftIndexToShift] = currentIndexValue
                
                leftIndexToShift += 1
            }
        }
        
        return leftIndexToShift
    }
}