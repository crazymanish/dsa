// https://leetcode.com/problems/isomorphic-strings

class Solution {
    func isIsomorphic(_ s: String, _ t: String) -> Bool {
        var hashMap: [Character : Character] = [:]
        var isIsomorphic = true
        
        for index in 0..<s.count {
            let sValue = s[index]
            let tValue = t[index]
            
            if let hashMapTValue = hashMap[sValue] {
                if hashMapTValue != tValue {
                    isIsomorphic = false
                    break
                }
            } else {
                hashMap[sValue] = tValue
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