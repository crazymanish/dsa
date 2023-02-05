class Solution {
    func findAnagrams(_ s: String, _ p: String) -> [Int] {
        var patternHashMap: [Character: Int] = [:]
        for character in p {
            patternHashMap[character] = patternHashMap[character, default: 0] + 1
        }

        let word = Array(s)
        var anagramsStartIndices: [Int] = []
        var count = p.count
        
        var startIndex = 0
        for endIndex in 0..<word.count {
            patternHashMap[word[endIndex]] = patternHashMap[word[endIndex], default: 0] - 1
            
            if patternHashMap[word[endIndex]]! >= 0 {
                count -= 1
                
                if count == 0 {
                    anagramsStartIndices.append(startIndex)
                }
            }
            
            while patternHashMap[word[endIndex]]! < 0 || count == 0 {
                patternHashMap[word[startIndex]] = patternHashMap[word[startIndex]]! + 1
                
                if patternHashMap[word[startIndex]]! > 0 {
                    count += 1
                }
                
                startIndex += 1
            }
        }

        return anagramsStartIndices
    }
}