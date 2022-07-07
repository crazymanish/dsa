// https://leetcode.com/problems/group-anagrams

class Solution {
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        if strs.count == 1 { return [strs] }
        
        var hashMap: [String : [String]] = [:]
        
        for str in strs {
            var isGroupFound = false
            for (key, value) in hashMap {
                if isAnagram(str, key) {
                    hashMap[key] = value + [str]
                    isGroupFound = true
                    break
                }
            }
            
            if isGroupFound == false { hashMap[str] = [str] }
        }
        
        var output: [[String]] = []
        for (_, value) in hashMap {
            output.append(value.sorted())
        }
        
        return output
    }

    private func isAnagram(_ s: String, _ t: String) -> Bool {
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