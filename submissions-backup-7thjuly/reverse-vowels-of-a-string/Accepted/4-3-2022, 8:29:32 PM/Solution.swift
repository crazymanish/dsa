// https://leetcode.com/problems/reverse-vowels-of-a-string

class Solution {
    private let vowelsHashMap = ["a": true, "e": true, "i": true, "o": true, "u": true]
    
    func reverseVowels(_ s: String) -> String {
        var sArray: [String] = []
        for char in s { sArray.append(String(char)) }
        
        var leftPointerIndex = 0
        var rightPointerIndex = s.count-1
        
        while leftPointerIndex < rightPointerIndex {
            var leftPointerValue = sArray[leftPointerIndex]
            var rightPointerValue = sArray[rightPointerIndex]
            
            if isVowel(leftPointerValue) == false && isVowel(rightPointerValue) == false {
                leftPointerIndex += 1
                rightPointerIndex -= 1
            } else if isVowel(leftPointerValue) == true && isVowel(rightPointerValue) == false {
                rightPointerIndex -= 1
            } else if isVowel(leftPointerValue) == false && isVowel(rightPointerValue) == true {
                leftPointerIndex += 1
            } else {
                sArray[leftPointerIndex] = rightPointerValue
                sArray[rightPointerIndex] = leftPointerValue
                
                leftPointerIndex += 1
                rightPointerIndex -= 1
            }
        }
        
        return sArray.joined(separator: "")
    }
    
    private func isVowel(_ string: String) -> Bool { 
        return vowelsHashMap[string.lowercased()] != nil 
    }
}