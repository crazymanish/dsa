// https://leetcode.com/problems/isomorphic-strings

class Solution {
    func isIsomorphic(_ s: String, _ t: String) -> Bool {
        if s.count != t.count { return false }
        
        var hashMap: [Character : Character] = [:] // Map s with t
        var hashMap2: [Character : Bool] = [:] // Just keep track of t that already mapped
        var isIsomorphic = true
        
        for index in 0..<s.count {
            let sValue = s[index]
            let tValue = t[index]
            
            if hashMap[sValue] == nil {
                hashMap[sValue] = tValue
                
                if hashMap2[tValue] == nil {
                    hashMap2[tValue] = true   
                } else {
                    isIsomorphic = false
                    break    
                }
                
                continue
            }
            
            if let hashMapTValue = hashMap[sValue], hashMapTValue != tValue {
                isIsomorphic = false
                break   
            }
        }
        
        return isIsomorphic
    }
}

private extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}