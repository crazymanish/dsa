// https://leetcode.com/problems/find-minimum-in-rotated-sorted-array

class Solution {
    func findMin(_ nums: [Int]) -> Int {
        let target = nums[0]
        let lastIndex = nums.count-1
        
        func rotatedArrayBinarySearch(_ startIndex: Int, _ endIndex: Int) -> Int {
            if startIndex > endIndex { return target } // Not found, base-case
            
            let midIndex = startIndex + (endIndex-startIndex) / 2
            let midIndexValue = nums[midIndex]
            
            var output = min(midIndexValue, target)
            
            // Look into left side
            let leftOutput = rotatedArrayBinarySearch(startIndex, midIndex-1)
            output = min(leftOutput, output)
            
            // Look into right side
            let rightOutput = rotatedArrayBinarySearch(midIndex+1, endIndex)
            output = min(rightOutput, output)
            
            // Look into right side for rotated
            let rightValue = midIndex+1 <= lastIndex ? nums[midIndex+1] : Int.max
            if rightValue < midIndexValue { 
                let rotatedOutput = rotatedArrayBinarySearch(midIndex+1, endIndex) 
                output = min(rotatedOutput, output)
            }
            
            return output
        }
        
        return rotatedArrayBinarySearch(0, lastIndex)
    }
}