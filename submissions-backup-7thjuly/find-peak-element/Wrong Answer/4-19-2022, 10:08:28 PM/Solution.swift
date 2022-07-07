// https://leetcode.com/problems/find-peak-element

class Solution {
    func findPeakElement(_ nums: [Int]) -> Int {
        
        func findPeakElementIndex(_ startIndex: Int, _ endIndex: Int) -> Int {
            if endIndex - startIndex < 2 { return 0 }
            
            let midIndex = startIndex + ((endIndex - startIndex) / 2)
            
            var isGreaterThanLeft = true
            if (midIndex-1 >= startIndex && nums[midIndex] < nums[midIndex-1]) {
                isGreaterThanLeft = false
            }
            
            var isGreaterThanRight = true
            if (midIndex+1 < endIndex && nums[midIndex] < nums[midIndex+1]) {
                isGreaterThanRight = false
            }
            
            if isGreaterThanLeft && isGreaterThanRight {
                return midIndex
            }
            
            let leftPeakIndex = findPeakElementIndex(startIndex, midIndex)
            let rightPeakIndex = findPeakElementIndex(midIndex, endIndex)
            
            if leftPeakIndex != 0 { return leftPeakIndex }
            if rightPeakIndex != 0 { return rightPeakIndex }
            
            return 0
        }
        
        return findPeakElementIndex(0, nums.count)
    }
}