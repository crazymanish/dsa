class Solution {
    func isAnagram(_ s: String, _ t: String) -> Bool {
        var hashMapS = hashMap(s)
        var hashMapT = hashMap(t)
        
        var isHashAnagram = true
        isHashAnagram = isAnagram(hashMapS, hashMapT)
        
        if isHashAnagram {
            isHashAnagram = isAnagram(hashMapT, hashMapS)
        }
        
        return isHashAnagram
    }
    
    private func isAnagram(
        _ hashMapS: [Character : Int], 
        _ hashMapT: [Character : Int]) -> Bool {
        var isAnagram = true
        
        for (key, value) in hashMapT {
            let sValue = hashMapS[key] ?? -1
            if sValue != value {
                isAnagram = false
                break
            }
        }
        
        return isAnagram
    }
    
    private func hashMap(_ text: String) -> [Character : Int] {
        var hashMap: [Character : Int] = [:]
        
        for char in text {
            let hashMapValue = hashMap[char] ?? 0
            hashMap[char] = hashMapValue + 1
        }
        
        return hashMap
    }
}