class Solution {
    func peakIndexInMountainArray(_ arr: [Int]) -> Int {
        var startIndex = 0
        var endIndex = arr.count-1
        var midIndex = -1
        
        while startIndex <= endIndex {
            midIndex = startIndex + (endIndex-startIndex) / 2
            let midIndexValue = arr[midIndex]
            
            var leftValueOfMidIndex = -1
            var rightValueOfMidIndex = -1
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