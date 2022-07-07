// https://leetcode.com/problems/maximum-number-of-words-you-can-type

class Solution {
    func canBeTypedWords(_ text: String, _ brokenLetters: String) -> Int {
        var brokenCharHashMap: [Character : Bool] = [:]
        for char in brokenLetters { brokenCharHashMap[char] = true }
        
        var canBeTypedWords = 0
        
        let words = text.components(separatedBy: " ")
        for word in words {
            var canTypeCurrentWord = true
            for char in word {
                if brokenCharHashMap[char] != nil {
                    canTypeCurrentWord = false
                    break
                }
            }
            
            if canTypeCurrentWord { canBeTypedWords += 1 }
            
        }
        
        return canBeTypedWords
    }
}