// https://leetcode.com/problems/maximum-number-of-words-found-in-sentences

class Solution {
    func mostWordsFound(_ sentences: [String]) -> Int {
        var maxWords = Int.min
        
        for sentence in sentences {
            var currentWords = 1
            for char in sentence {
                if char == " " { currentWords += 1 }
            }
            
            maxWords = max(maxWords, currentWords)
        }
        
        return maxWords
    }
}