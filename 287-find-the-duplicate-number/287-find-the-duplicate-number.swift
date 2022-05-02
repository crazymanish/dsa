class Solution {
    func findDuplicate(_ nums: [Int]) -> Int {
        let numsSorted = nums.sorted()
        let lastIndex = nums.count-1
        
        func findDuplicateUsingRecursiveBinarySearch(_ startIndex: Int, _ endIndex: Int) -> Int {
            if startIndex > endIndex { return -1 } // Not found, base-case
            
            let midIndex = startIndex + (endIndex-startIndex) / 2
            let midIndexValue = numsSorted[midIndex]
            
            let leftValue = midIndex-1 >= 0 ? numsSorted[midIndex-1] : -1
            let rightValue = midIndex+1 <= lastIndex ? numsSorted[midIndex+1] : -1
            
            if midIndexValue == leftValue || midIndexValue == rightValue { return midIndexValue } // Found answer
            
            let leftSideDuplicateValue = findDuplicateUsingRecursiveBinarySearch(startIndex, midIndex-1) // Find left side
            if leftSideDuplicateValue != -1 {
                return leftSideDuplicateValue
            } else {
                return findDuplicateUsingRecursiveBinarySearch(midIndex+1, endIndex) // Find right side
            }
        }
        
        return findDuplicateUsingRecursiveBinarySearch(0, lastIndex)
    }
}