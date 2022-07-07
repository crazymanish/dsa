// https://leetcode.com/problems/binary-search

class Solution {
    func search(_ nums: [Int], _ target: Int) -> Int {
        func recursiveBinarySearch(_ startIndex: Int, _ endIndex: Int) -> Int {
            if startIndex > endIndex { return -1 } // Not found base-condition
            
            let midIndex = startIndex + (endIndex-startIndex) / 2
            let midIndexValue = nums[midIndex]
            
            if midIndexValue == target { return midIndex } // Found answer
            
            if midIndexValue > target {
                return recursiveBinarySearch(startIndex, midIndex-1) // Look into left side
            } else {
                return recursiveBinarySearch(midIndex+1, endIndex) // Look into right side
            }
        }
        
        return recursiveBinarySearch(0, nums.count-1)
    }
}