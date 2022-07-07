// https://leetcode.com/problems/find-common-characters

class Solution {
    func commonChars(_ words: [String]) -> [String] {
        if words.isEmpty { return [] }

        var result = words[0]
        
        for word in words {
            var currentWord = word
            var newResult = ""
            
            for char in result {
                if let index = currentWord.firstIndex(of: char) {
                    newResult.append(char)
                    currentWord.remove(at: index)
                }
            }
            
            result = newResult
        }
        
        return result.map { String($0) }
    }
}