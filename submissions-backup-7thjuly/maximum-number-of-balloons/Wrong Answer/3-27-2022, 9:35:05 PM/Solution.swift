// https://leetcode.com/problems/maximum-number-of-balloons

class Solution {
    func maxNumberOfBalloons(_ text: String) -> Int {
        var hashMap: [Character : Int] = [:]
        
        for char in text {
            let hashMapValue = hashMap[char] ?? 0
            hashMap[char] = hashMapValue + 1
        }
        
        var maxNumber = Int.max
        
        maxNumber = min(maxNumber, hashMap["b"] ?? 0)
        maxNumber = min(maxNumber, hashMap["a"] ?? 0)
        maxNumber = min(maxNumber, hashMap["l"] ?? 0)
        maxNumber = min(maxNumber, hashMap["l"] ?? 0)
        maxNumber = min(maxNumber, hashMap["o"] ?? 0)
        maxNumber = min(maxNumber, hashMap["o"] ?? 0)
        maxNumber = min(maxNumber, hashMap["n"] ?? 0)
        
        return maxNumber
    }
}