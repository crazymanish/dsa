// https://leetcode.com/problems/two-sum-ii-input-array-is-sorted

class Solution {
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        func recursiveBinarySearch(_ startIndex: Int, _ endIndex: Int) -> Int {
            if startIndex > endIndex { return -1 } // Not found base-condition
            
            let midIndex = startIndex + (endIndex-startIndex) / 2
            let midIndexValue = numbers[midIndex]
            
            if midIndexValue == remainingTarget { return midIndex } // Found answer
            
            if midIndexValue > remainingTarget {
                return recursiveBinarySearch(startIndex, midIndex-1) // Look into left side
            } else {
                return recursiveBinarySearch(midIndex+1, endIndex) // Look into right side
            }
        }
        
        let lastIndex = numbers.count-1
        var remainingTarget = target
        
        for (index, number) in numbers.enumerated() {
            remainingTarget = target-number
            let remainingTargetIndex = recursiveBinarySearch(0, lastIndex)
            
            if remainingTargetIndex != -1 { return [index+1, remainingTargetIndex+1] }
        }
        
        return [-1, -1] // Not found
    }
}