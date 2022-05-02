class Solution {
    func singleNonDuplicate(_ nums: [Int]) -> Int {
        let lastIndex = nums.count-1
        
        func findSingleNumberUsingRecursiveBinarySearch(_ startIndex: Int, _ endIndex: Int) -> Int {
            if startIndex > endIndex { return -1 } // Not found, base-case
            
            let midIndex = startIndex + (endIndex-startIndex) / 2
            let midIndexValue = nums[midIndex]
            
            let leftValue = midIndex-1 >= 0 ? nums[midIndex-1] : -1
            let rightValue = midIndex+1 <= lastIndex ? nums[midIndex+1] : -1
            
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