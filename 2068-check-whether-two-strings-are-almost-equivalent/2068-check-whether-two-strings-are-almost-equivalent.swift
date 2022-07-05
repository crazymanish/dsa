class Solution {
    func checkAlmostEquivalent(_ word1: String, _ word2: String) -> Bool {
        let word1HashMap = addIntoHashMap(word1)
        let word2HashMap = addIntoHashMap(word2)
        
        var isEquivalent = true
        isEquivalent = isAlmostEquivalent(word1HashMap, word2HashMap)
        
        if isEquivalent {
            isEquivalent = isAlmostEquivalent(word2HashMap, word1HashMap)
        }
        
        return isEquivalent
    }
    
    private func addIntoHashMap(_ word: String) -> [Character : Int] {
        var hashMap: [Character : Int] = [:]
        
        for char in word {
            if let hashMapValue = hashMap[char] {
                hashMap[char] = hashMapValue + 1
            } else {
                hashMap[char] = 1
            }
        }
        
        return hashMap
    }
    
    private func isAlmostEquivalent(_ hash1: [Character : Int], _ hash2: [Character : Int]) -> Bool {
        var isAlmostEquivalent = true
        
        for (key, value) in hash1 {
            let hash2Value = hash2[key] ?? 0
            
            if abs(hash2Value - value) > 3 {
                isAlmostEquivalent = false
                break   
            }
        }
        
        return isAlmostEquivalent
    }
}