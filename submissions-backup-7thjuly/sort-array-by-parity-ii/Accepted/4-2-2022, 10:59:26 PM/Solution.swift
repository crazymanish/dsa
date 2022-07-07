// https://leetcode.com/problems/sort-array-by-parity-ii

class Solution {
    // Follow Up: Could you solve it in-place?
    // Yes: done...see below
    func sortArrayByParityII(_ nums: [Int]) -> [Int] {
        let numsCount = nums.count
        var mutableNums = nums
        
        var currentEvenIndex = 0
        while currentEvenIndex < numsCount {
            let currentEvenIndexValue = mutableNums[currentEvenIndex]
            
            // If Even-index value is odd...then search for next Odd-index Even-value 
            // and swap :wink:    
            if currentEvenIndexValue.isOdd {
                var currentOddIndex = 1
                
                while mutableNums[currentOddIndex].isOdd {
                    currentOddIndex += 2 // next odd-index
                }
                
                
                // Swap ODD with EVEN 
                mutableNums[currentEvenIndex] = mutableNums[currentOddIndex]
                mutableNums[currentOddIndex] = currentEvenIndexValue
            }
            
            
            currentEvenIndex += 2 // next even-index
        }
        
        return mutableNums
    }
}

extension Int {
    var isEven: Bool { self % 2 == 0 }
    var isOdd: Bool { !isEven }
}