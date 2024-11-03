class Solution {
    func moveZeroes(_ nums: inout [Int]) {
        guard nums.count > 1 else { return }
        
        var zeroPtr = 0
        var nonZeroPtr = 0
        
        for num in nums {
            if num != 0 {
                swap(zeroPtr, nonZeroPtr)
                zeroPtr += 1
            }
            
            nonZeroPtr += 1
        }
        
        func swap(_ index1: Int, _ index2: Int) {
            let temp = nums[index1]
            nums[index1] = nums[index2]
            nums[index2] = temp
        }
    }
}

/*
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
*/