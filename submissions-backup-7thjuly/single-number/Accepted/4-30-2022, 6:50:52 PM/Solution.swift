// https://leetcode.com/problems/single-number

class Solution {
    func singleNumber(_ nums: [Int]) -> Int {
        let numsSorted = nums.sorted()
        let lastIndex = nums.count-1
        
        func findSingleNumberUsingRecursiveBinarySearch(_ startIndex: Int, _ endIndex: Int) -> Int {
            if startIndex > endIndex { return -1 } // Not found, base-case
            
            let midIndex = startIndex + (endIndex-startIndex) / 2
            let midIndexValue = numsSorted[midIndex]
            
            let leftValue = midIndex-1 >= 0 ? numsSorted[midIndex-1] : -1
            let rightValue = midIndex+1 <= lastIndex ? numsSorted[midIndex+1] : -1
            
            if midIndexValue != leftValue && midIndexValue != rightValue { return midIndexValue } // Found answer
            
            let leftSideDuplicateValue = findSingleNumberUsingRecursiveBinarySearch(startIndex, midIndex-1) // Find left side
            if leftSideDuplicateValue != -1 {
                return leftSideDuplicateValue
            } else {
                return findSingleNumberUsingRecursiveBinarySearch(midIndex+1, endIndex) // Find right side
            }
        }
        
        return findSingleNumberUsingRecursiveBinarySearch(0, lastIndex)
    }
}