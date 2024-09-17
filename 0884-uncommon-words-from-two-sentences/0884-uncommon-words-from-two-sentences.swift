class Solution {
    func uncommonFromSentences(_ s1: String, _ s2: String) -> [String] {
        var hashMap: [String : Int] = [:]
        
        let s1Words = s1.components(separatedBy: " ")
        let s2Words = s2.components(separatedBy: " ")
        
        for word in s1Words {
            let hashMapValue = hashMap[word] ?? 0
            hashMap[word] = hashMapValue + 1
        }
        
        for word in s2Words {
            let hashMapValue = hashMap[word] ?? 0
            hashMap[word] = hashMapValue + 1
        }
        
        var output: [String] = []
        for (key, value) in hashMap {
            if value == 1 { output.append(key) }
        }
        
        return output
    }
}