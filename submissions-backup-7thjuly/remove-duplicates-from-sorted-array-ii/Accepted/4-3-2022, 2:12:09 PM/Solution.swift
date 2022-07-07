// https://leetcode.com/problems/remove-duplicates-from-sorted-array-ii

class Solution {
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        let numsCount = nums.count
        if numsCount < 2 { return numsCount }
        
        // Trick is: left-shift index
        var leftShiftIndex = 2

        for index in 2..<numsCount {
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