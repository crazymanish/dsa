// https://leetcode.com/problems/count-negative-numbers-in-a-sorted-matrix

class Solution {
    func countNegatives(_ grid: [[Int]]) -> Int {
        func findFirstNegativeIndexUsingBinarySearch(_ array: [Int]) -> Int {
            if array[0] < 0 { return 0 }
            
            var startIndex = 0
            var endIndex = array.count-1
            
            var negativeIndex = -1
            var midIndex = startIndex + (endIndex-startIndex)/2
            while midIndex <= endIndex {
                let midIndexValue = array[midIndex]
                if midIndexValue >= 0 {
                    if midIndex+1 <= endIndex && array[midIndex+1] < 0 {
                        negativeIndex = midIndex+1
                        break
                    } else {
                        startIndex = midIndex+1
                        midIndex = startIndex + (endIndex-startIndex)/2
                    }
                } else {
                    if midIndex-1 >= startIndex && array[midIndex-1] > 0 {
                        negativeIndex = midIndex
                        break
                    } else {
                        endIndex = midIndex-1
                        midIndex = startIndex + (endIndex-startIndex)/2
                    }
                }
            }
            
            return negativeIndex
        }
        
        var output = 0
        for row in grid {
            let negativeIndex = findFirstNegativeIndexUsingBinarySearch(row)
            
            if negativeIndex != -1 {
                let negativeNumbersCount = row.count-negativeIndex
                output += negativeNumbersCount
            }
        }
        
        return output
    }
}