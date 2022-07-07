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
            
            // Find left,right value of midIndex
            let leftValue = midIndex-1 >= 0 ? nums[midIndex-1] : Int.min
            let rightValue = midIndex+1 <= lastIndex ? nums[midIndex+1] : Int.max
            
            // check left-right answer
            if midIndexValue > target && leftValue < target { return midIndex }
            if midIndexValue < target && rightValue > target { return midIndex+1 }
            
            if midIndexValue > target {
                return findInsertIndexUsingRecursiveBinarySearch(startIndex, midIndex-1) // Keep finding left side
            } else {
                return findInsertIndexUsingRecursiveBinarySearch(midIndex+1, endIndex) // Keep finding right side
            }
        }
        
        return findInsertIndexUsingRecursiveBinarySearch(0, lastIndex)
    }
}