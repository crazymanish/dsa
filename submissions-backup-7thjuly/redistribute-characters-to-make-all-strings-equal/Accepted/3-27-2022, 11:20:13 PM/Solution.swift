// https://leetcode.com/problems/redistribute-characters-to-make-all-strings-equal

class Solution {
    func makeEqual(_ words: [String]) -> Bool {
        var hashMap: [Character : Int] = [:]
        
        for word in words {
            for char in word {
                let hashMapValue = hashMap[char] ?? 0
                hashMap[char] = hashMapValue + 1
            }
        }
        
        let wordsCount = words.count
        
        if wordsCount == 1 { return true }
        
        var canMakeEqual = true
        for (_, value) in hashMap {
            if value % wordsCount != 0 {
                canMakeEqual = false
                break
            }
        }
        
        return canMakeEqual
    }
}