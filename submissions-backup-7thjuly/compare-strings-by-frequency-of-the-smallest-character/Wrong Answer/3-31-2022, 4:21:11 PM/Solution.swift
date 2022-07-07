// https://leetcode.com/problems/compare-strings-by-frequency-of-the-smallest-character

class Solution {
    func numSmallerByFrequency(_ queries: [String], _ words: [String]) -> [Int] {
        var wordsFrequency: [Int] = []
        for word in words { wordsFrequency.append(findMaxFrequency(word)) }
        
        wordsFrequency = wordsFrequency
            .sorted()
            .reversed()
        
        var output: [Int] = []
        
        for query in queries {
            let queryFrequency = findMaxFrequency(query)
            
            var diff = 0
            
            for wordFrequency in wordsFrequency {
                if wordFrequency > queryFrequency {
                    diff += 1
                } else {
                    break
                }
            }
            
            output.append(diff)
        }
        
        return output
    }
    
    private func findMaxFrequency(_ word: String) -> Int {
        var hashMap: [Character : Int] = [:]
        
        for char in word {
            let hashMapValue = hashMap[char] ?? 0
            hashMap[char] = hashMapValue + 1
        }
        
        return Array(hashMap.values)
            .sorted()
            .last!
    }
}