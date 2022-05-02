class Solution {
    func countNegatives(_ grid: [[Int]]) -> Int {
        func findFirstNegativeIndexUsingBinarySearch(_ array: [Int]) -> Int {
            if array[0] < 0 { return 0 }
            
            var startIndex = 0
            var endIndex = array.count-1
            
            var negativeIndex = -1
            while startIndex <= endIndex {
                let midIndex = startIndex + (endIndex-startIndex)/2
                let midIndexValue = array[midIndex]
                
                if midIndexValue >= 0 {
                    startIndex = midIndex+1
                } else {
                    if midIndex == startIndex {
                        negativeIndex = midIndex
                        break
                    } else if midIndex-1 >= startIndex && array[midIndex-1] >= 0 {
                        negativeIndex = midIndex
                        break
                    } else {
                        endIndex = midIndex-1
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