// https://leetcode.com/problems/find-peak-element

class Solution {
    func findPeakElement(_ nums: [Int]) -> Int {
        return peakIndexInMountainArray(nums)
    }

    // Ditto code: 852. Peak Index in a Mountain Array
    // https://leetcode.com/problems/peak-index-in-a-mountain-array/
    private func peakIndexInMountainArray(_ arr: [Int]) -> Int {
        var startIndex = 0
        var endIndex = arr.count-1
        var midIndex = -1
        
        while startIndex <= endIndex {
            midIndex = startIndex + (endIndex-startIndex) / 2
            let midIndexValue = arr[midIndex]
            
            var leftValueOfMidIndex = Int.min
            var rightValueOfMidIndex = Int.min
            if midIndex-1 >= startIndex { leftValueOfMidIndex = arr[midIndex-1] }
            if midIndex+1 <= endIndex { rightValueOfMidIndex = arr[midIndex+1] }
            
            if midIndexValue > leftValueOfMidIndex && midIndexValue > rightValueOfMidIndex {
                break // we found the answer
            } else if leftValueOfMidIndex > midIndexValue {
                endIndex = midIndex-1 // Let's find answer in left-side
            } else {
                startIndex = midIndex+1 // Let's find answer in right-side
            }
        }
        
        return midIndex
    }
}