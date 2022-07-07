// https://leetcode.com/problems/remove-duplicates-from-sorted-array

class Solution {
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        // Just shift non-duplicate elements to left-most
        
        var leftIndexToShift = 0 
        for index in 1..<nums.count {
            let previousIndexValue = nums[index-1]
            let currentIndexValue = nums[index]
            
            if currentIndexValue == previousIndexValue {
               // noop: ignore left-shift, 
               // this is duplicate element
            } else {
                nums[leftIndexToShift+1] = currentIndexValue
                
                leftIndexToShift += 1
            }
        }
        
        return leftIndexToShift + 1
    }
}