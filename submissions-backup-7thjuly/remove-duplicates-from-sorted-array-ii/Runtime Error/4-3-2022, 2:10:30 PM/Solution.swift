// https://leetcode.com/problems/remove-duplicates-from-sorted-array-ii

class Solution {
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        // Trick is: left-shift index
        var leftShiftIndex = 2

        for index in 2..<nums.count {
            let currentIndexValue = nums[index]
            let leftShiftIndexValue = nums[leftShiftIndex-2]
            
            if currentIndexValue > leftShiftIndexValue {
                nums[leftShiftIndex] = currentIndexValue
                
                leftShiftIndex += 1
            }
        }
        
        return leftShiftIndex
    }
}