// https://leetcode.com/problems/find-peak-element

class Solution {
    func findPeakElement(_ nums: [Int]) -> Int {
        
        func findPeakElementIndex(_ startIndex: Int, _ endIndex: Int) -> Int {
            if endIndex - startIndex < 2 { return -1 }
            
            let midIndex = startIndex + ((endIndex - startIndex) / 2)
            
            if nums[midIndex] > nums[midIndex-1] && nums[midIndex] > nums[midIndex+1] {
                return midIndex
            }
            
            let leftPeakIndex = findPeakElementIndex(startIndex, midIndex-1)
            let rightPeakIndex = findPeakElementIndex(midIndex+1, endIndex)
            
            if leftPeakIndex != -1 { return leftPeakIndex }
            if rightPeakIndex != -1 { return rightPeakIndex }
            
            return -1
        }
        
        return findPeakElementIndex(0, nums.count)
    }
}