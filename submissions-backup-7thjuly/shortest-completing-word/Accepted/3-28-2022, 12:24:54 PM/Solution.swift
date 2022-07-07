// https://leetcode.com/problems/shortest-completing-word

class Solution {
    func shortestCompletingWord(_ licensePlate: String, _ words: [String]) -> String {
        var hashMap: [Character : Int] = [:]
        
        for scalar in licensePlate.lowercased().unicodeScalars {
            let value = scalar.value
            
            if (value >= 97 && value <= 122) { // to find a-z
                let char = Character(scalar)
                let hashMapValue = hashMap[char] ?? 0
                hashMap[char] = hashMapValue + 1
            }
        }
        
        var shortestWord: String? = nil
        
        for word in words {
            var licensePlateHashMap = hashMap
            
            for char in word {
                if let hashMapValue = licensePlateHashMap[char] {
                    licensePlateHashMap[char] = hashMapValue - 1
                }
            }
            
            var canCompleteWord = true
            for (_, value) in licensePlateHashMap {
                if value > 0 {
                    canCompleteWord = false
                    break
                }
            }
            
            if canCompleteWord {
                if let previousShortestWord = shortestWord {
                    if word.count < previousShortestWord.count { shortestWord = word }
                } else {
                    shortestWord = word
                }
            }
        }
        
        return shortestWord!
    }
}