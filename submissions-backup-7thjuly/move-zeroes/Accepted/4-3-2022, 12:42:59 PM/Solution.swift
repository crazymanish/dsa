// https://leetcode.com/problems/move-zeroes

class Solution {
    func moveZeroes(_ nums: inout [Int]) {
        var currentZeroIndex = -1
        
        var currentIndex = 0 
        while currentIndex < nums.count {
            let currentIndexValue = nums[currentIndex]
            
            if currentIndexValue == 0 {
                currentZeroIndex = currentIndex
                
                var currentNonZeroIndex = currentZeroIndex
                for index in currentIndex+1..<nums.count {
                    if nums[index] != 0 {
                        currentNonZeroIndex = index
                        break
                    }
                }
                
                //swap
                nums[currentIndex] = nums[currentNonZeroIndex]
                nums[currentNonZeroIndex] = currentIndexValue
            }   
            
            currentIndex += 1
        }
    }
}