class Solution {
    func countCharacters(_ words: [String], _ chars: String) -> Int {
        var charsHashMap: [Character : Int] = [:]
        
        for char in chars {
            if let hashMapValue = charsHashMap[char] {
                charsHashMap[char] = hashMapValue + 1
            } else {
                charsHashMap[char] = 1
            }
        }
        
        var outputWordsLength = 0
        
        for word in words {
            var hashMap = charsHashMap
            var canFormWord = true
            for char in word {
                if let hashMapValue = hashMap[char] {
                    if hashMapValue == 0 {
                        canFormWord = false
                        break
                    } else {
                        hashMap[char] = hashMapValue - 1
                    }
                } else {
                    canFormWord = false
                    break
                }
            }
            
            if canFormWord { outputWordsLength += word.count }
        }
        
        return outputWordsLength
    }
}