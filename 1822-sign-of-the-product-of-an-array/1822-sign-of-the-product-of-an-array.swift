class Solution {
    func arraySign(_ nums: [Int]) -> Int {
        var noOfNegativeNums = 0
        
        for num in nums {
            if num < 0 {
                noOfNegativeNums += 1
            } else if num == 0 { 
                return 0 // if nums array contains zero. 0 * n = 0
            }
        }
        
        if noOfNegativeNums % 2 == 0 { return 1 } // if its even: -2 * -2 = 4. So result will be 1.
        
        return -1 // if its odd: -2 * -2 * -1 = -4. In this way result will be -1.
    }
}