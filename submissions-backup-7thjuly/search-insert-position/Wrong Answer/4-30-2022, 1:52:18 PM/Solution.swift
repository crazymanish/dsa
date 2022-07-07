// https://leetcode.com/problems/search-insert-position

class Solution {
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        func findInsertIndexUsingRecursiveBinarySearch(_ startIndex: Int, _ endIndex: Int) -> Int {
            if startIndex > endIndex { return 0 } // Not-found exit base-case
            
            let midIndex = startIndex + (endIndex-startIndex) / 2
            let midIndexValue = nums[midIndex]
            
            // Found answer that is equal to target
            if midIndexValue == target { return midIndex }
            
            // Found answer, when startIndex & endIndex pointing same element
            if midIndex == startIndex && midIndex == endIndex {
                if midIndexValue > target { return midIndex }
                if midIndexValue < target { return midIndex+1 }
            }
            
            if midIndexValue > target {
                return findInsertIndexUsingRecursiveBinarySearch(startIndex, midIndex-1) // Keep finding left side
            } else {
                return findInsertIndexUsingRecursiveBinarySearch(midIndex+1, endIndex) // Keep finding right side
            }
        }
        
        return findInsertIndexUsingRecursiveBinarySearch(0, nums.count-1)
    }
}