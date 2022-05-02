class Solution {
    func findMin(_ nums: [Int]) -> Int {
        let target = nums[0]
        let lastIndex = nums.count-1
        
        func rotatedArrayBinarySearch(_ startIndex: Int, _ endIndex: Int) -> Int {
            if startIndex > endIndex { return target } // Not found, base-case
            
            let midIndex = startIndex + (endIndex-startIndex) / 2
            let midIndexValue = nums[midIndex]
            
            var output = min(midIndexValue, target)
            
            // Look into left side
            var previousIndex = midIndex-1
            while previousIndex >= 0 && nums[previousIndex] == midIndexValue { previousIndex -= 1 }
            let leftOutput = rotatedArrayBinarySearch(startIndex, previousIndex)
            output = min(leftOutput, output)
            
            // Look into right side
            var nextIndex = midIndex+1
            while nextIndex <= lastIndex && nums[nextIndex] == midIndexValue { nextIndex += 1 }
            let rightOutput = rotatedArrayBinarySearch(nextIndex, endIndex)
            output = min(rightOutput, output)
            
            // Look into right side for rotated
            let rightValue = midIndex+1 <= lastIndex ? nums[midIndex+1] : Int.max
            if rightValue < midIndexValue { 
                var rightIndex = midIndex+1
                let rightValue = rightIndex <= lastIndex ? nums[rightIndex] : Int.max
                while rightIndex <= lastIndex && nums[rightIndex] == rightValue { rightIndex += 1 }
                let rotatedOutput = rotatedArrayBinarySearch(rightIndex, endIndex) 
                output = min(rotatedOutput, output)
            }
            
            return output
        }
        
        return rotatedArrayBinarySearch(0, lastIndex)
    }
}