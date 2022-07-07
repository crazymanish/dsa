// https://leetcode.com/problems/maximum-number-of-balloons

class Solution {
    func maxNumberOfBalloons(_ text: String) -> Int {
        var hashMap: [Character : Int] = [:]
        
        for char in text {
            let hashMapValue = hashMap[char] ?? 0
            hashMap[char] = hashMapValue + 1
        }
        
        var maxNumber = Int.max
        
        if let b = hashMap["b"],
        let a = hashMap["a"],
        let l = hashMap["l"],
        let o = hashMap["o"],
        let n = hashMap["n"] {
            maxNumber = min(maxNumber, b)
            maxNumber = min(maxNumber, a)
            maxNumber = min(maxNumber, l/2)
            maxNumber = min(maxNumber, o/2)
            maxNumber = min(maxNumber, n)   
        } else {
            maxNumber = 0
        }
        
        return maxNumber
    }
}