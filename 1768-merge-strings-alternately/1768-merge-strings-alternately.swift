class Solution {
    func mergeAlternately(_ word1: String, _ word2: String) -> String {
        let word1Array = Array(word1)
        let word2Array = Array(word2)
        
        let word1Count = word1Array.count
        let word2Count = word2Array.count
        
        var output = ""
        
        for index in 0..<max(word1Count, word2Count) {
            if index < word1Count {
                output.append(String(word1Array[index]))
            }
            
            if index < word2Count {
                output.append(String(word2Array[index]))
            }
        }
        
        return output
    }
}