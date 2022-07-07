// https://leetcode.com/problems/search-insert-position

class Solution {
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        let lastIndex = nums.count-1
        
        func findInsertIndexUsingRecursiveBinarySearch(_ startIndex: Int, _ endIndex: Int) -> Int {
            if startIndex > endIndex { return -1 } // Not-found exit base-case
            
            let midIndex = startIndex + (endIndex-startIndex) / 2
            let midIndexValue = nums[midIndex]
            
            // Found answer that is equal to target
            if midIndexValue == target { return midIndex }
            
            // Check answer, when midIndex is the first-index
            if midIndex == 0 && midIndexValue < target { return midIndex+1 }
            if midIndex == 0 && midIndexValue > target { return midIndex }
            
            // Check answer, when midIndex is the last-index
            if midIndex == lastIndex && midIndexValue < target { return midIndex+1 }
            if midIndex == lastIndex && midIndexValue > target { return midIndex }
            
            // check left-right answer
            if midIndex-1 >= 0 && midIndexValue > target && nums[midIndex-1] < target { return midIndex }
            if midIndex+1 <= lastIndex && midIndexValue < target && nums[midIndex+1] > target { return midIndex+1 }
            
            if midIndexValue > target {
                return findInsertIndexUsingRecursiveBinarySearch(startIndex, midIndex-1) // Keep finding left side
            } else {
                return findInsertIndexUsingRecursiveBinarySearch(midIndex+1, endIndex) // Keep finding right side
            }
        }
        
        return findInsertIndexUsingRecursiveBinarySearch(0, lastIndex)
    }
}