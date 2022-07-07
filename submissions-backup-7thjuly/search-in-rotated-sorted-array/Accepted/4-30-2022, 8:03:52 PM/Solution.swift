// https://leetcode.com/problems/search-in-rotated-sorted-array

class Solution {
    func search(_ nums: [Int], _ target: Int) -> Int {
        let lastIndex = nums.count-1
        
        func rotatedArrayBinarySearch(_ startIndex: Int, _ endIndex: Int) -> Int {
            if startIndex > endIndex { return -1 } // Not found, base-case
            
            let midIndex = startIndex + (endIndex-startIndex) / 2
            let midIndexValue = nums[midIndex]
            
            if midIndexValue == target { return midIndex } // Found answer
            
            // Look into left side
            var outputIndex = rotatedArrayBinarySearch(startIndex, midIndex-1)
            
            // Look into right side
            if outputIndex == -1 { outputIndex = rotatedArrayBinarySearch(midIndex+1, endIndex) }
            
            // Look into right side for rotated
            if outputIndex == -1 {
                let rightValue = midIndex+1 <= lastIndex ? nums[midIndex+1] : Int.max
                if rightValue < midIndexValue { outputIndex = rotatedArrayBinarySearch(midIndex+1, endIndex) }    
            }
            
            return outputIndex
        }
        
        return rotatedArrayBinarySearch(0, lastIndex)
    }
}