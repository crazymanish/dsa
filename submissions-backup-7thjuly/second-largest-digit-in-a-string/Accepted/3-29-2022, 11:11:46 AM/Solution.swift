// https://leetcode.com/problems/second-largest-digit-in-a-string

class Solution {
    func secondHighest(_ s: String) -> Int {
        var hashMap: [Character : Bool] = [:]
        
        for char in s { hashMap[char] = true }
        
        var largestDigit = -1
        
        for digit in 0...9 {
            let char = Character(String(digit))
            if hashMap[char] != nil {
                largestDigit = max(largestDigit, digit)
            }
        }
        
        var secondLargestDigit = -1
        
        if largestDigit != -1 {
            for digit in 0...9 {
                let char = Character(String(digit))
                if hashMap[char] != nil, digit < largestDigit  {
                    secondLargestDigit = max(secondLargestDigit, digit)
                }
            }
        }
        
        return secondLargestDigit
    }
}