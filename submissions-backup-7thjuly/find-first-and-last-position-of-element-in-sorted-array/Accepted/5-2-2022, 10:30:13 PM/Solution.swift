// https://leetcode.com/problems/find-first-and-last-position-of-element-in-sorted-array

class Solution {
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        let lastIndex = nums.count-1
        
        func findTargetUsingBinarySearch(_ startIndex: Int, _ endIndex: Int) -> Int {
            if startIndex > endIndex { return -1 } // Not found, base-case
            
            let midIndex = startIndex + (endIndex-startIndex) / 2
            let midIndexValue = nums[midIndex]
            
            let leftValue = midIndex-1 >= 0 ? nums[midIndex-1] : Int.min
            let rightValue = midIndex+1 <= lastIndex ? nums[midIndex+1] : Int.max
            
            if leftMostSearch { // LeftMost search answer
                if midIndexValue == target && midIndexValue != leftValue { return midIndex }
                
                if midIndexValue >= target { return findTargetUsingBinarySearch(startIndex, midIndex-1) }
                if midIndexValue < target { return findTargetUsingBinarySearch(midIndex+1, endIndex) }
                
            } else { // RightMost search answer
                if midIndexValue == target && midIndexValue != rightValue { return midIndex }
                
                if midIndexValue <= target { return findTargetUsingBinarySearch(midIndex+1, endIndex) }
                if midIndexValue > target { return findTargetUsingBinarySearch(startIndex, midIndex-1) }
            }
            
            return -1
        }
        
        // LeftMost index search
        var leftMostSearch = true
        let leftIndex = findTargetUsingBinarySearch(0, lastIndex)
        
        // RightMost index search
        leftMostSearch = false
        let rightIndex = findTargetUsingBinarySearch(0, lastIndex)
        
        return [leftIndex, rightIndex]
    }
}