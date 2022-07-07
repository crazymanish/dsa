// https://leetcode.com/problems/sort-array-by-parity

class Solution {
    func sortArrayByParity(_ nums: [Int]) -> [Int] {
        var mutableNums = nums
        var leftPointer = 0
        var rightPointer = nums.count-1
        
        while leftPointer < rightPointer {
            let leftValue = mutableNums[leftPointer]
            let rightValue = mutableNums[rightPointer]
            
            if leftValue.isEven {
                leftPointer += 1
            } else if rightValue.isOdd {
                rightPointer -= 1
            } else if leftValue.isOdd && rightValue.isEven {
                // swap values
                mutableNums[leftPointer] = rightValue
                mutableNums[rightPointer] = leftValue
                
                leftPointer += 1
                rightPointer -= 1
            } else {
                leftPointer += 1
                rightPointer -= 1   
            }
        }
        
        return mutableNums
    }
}

extension Int {
    var isEven: Bool { self % 2 == 0 }
    var isOdd: Bool { !isEven }
}