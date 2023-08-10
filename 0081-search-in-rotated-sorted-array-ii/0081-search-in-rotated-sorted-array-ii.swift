class Solution {
    func search(_ nums: [Int], _ target: Int) -> Bool {
        let lastIndex = nums.count-1
        
        func rotatedArrayBinarySearch(_ startIndex: Int, _ endIndex: Int) -> Int {
            if startIndex > endIndex { return -1 } // Not found, base-case
            
            let midIndex = startIndex + (endIndex-startIndex) / 2
            let midIndexValue = nums[midIndex]
            
            if midIndexValue == target { return midIndex } // Found answer
                        
            // Look into left side
            var previousIndex = midIndex-1
            while previousIndex >= 0 && nums[previousIndex] == midIndexValue { previousIndex -= 1 }
            var outputIndex = rotatedArrayBinarySearch(startIndex, previousIndex)
            
            // Look into right side
            var nextIndex = midIndex+1
            while nextIndex <= lastIndex && nums[nextIndex] == midIndexValue { nextIndex += 1 }
            if outputIndex == -1 { outputIndex = rotatedArrayBinarySearch(nextIndex, endIndex) }
            
            // Look into right side for rotated
            if outputIndex == -1 {
                var rightIndex = midIndex+1
                let rightValue = rightIndex <= lastIndex ? nums[rightIndex] : Int.max
                while rightIndex <= lastIndex && nums[rightIndex] == rightValue { rightIndex += 1 }
                
                if rightValue < midIndexValue { outputIndex = rotatedArrayBinarySearch(rightIndex, endIndex) }    
            }
            
            return outputIndex
        }
        
        return rotatedArrayBinarySearch(0, lastIndex) != -1
    }
}