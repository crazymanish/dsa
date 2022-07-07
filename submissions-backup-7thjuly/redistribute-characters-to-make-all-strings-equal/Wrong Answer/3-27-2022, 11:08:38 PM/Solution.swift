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
        var canMakeEqual = true
        for (_, value) in hashMap {
            if value != wordsCount {
                canMakeEqual = false
                break
            }
        }
        
        return canMakeEqual
    }
}