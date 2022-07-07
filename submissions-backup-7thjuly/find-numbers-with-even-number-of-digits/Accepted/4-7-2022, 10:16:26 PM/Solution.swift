// https://leetcode.com/problems/find-numbers-with-even-number-of-digits

class Solution {
    func findNumbers(_ nums: [Int]) -> Int {
        var output = 0
        
        for num in nums {
            if isEvenNumberOfDigits(num) { output += 1 }
        }
        
        return output
    }
    
    func isEvenNumberOfDigits(_ num: Int) -> Bool {
        var number = num
        var numberOfDigits = 0
        
        while number > 0 {
            numberOfDigits += 1
            
            number = number / 10
        }
        
        return numberOfDigits % 2 == 0
    }
}