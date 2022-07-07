// https://leetcode.com/problems/isomorphic-strings

class Solution {
    func isIsomorphic(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else { return false }
        
        var sHashMap: [Character:Character] = [:]
        var tHashMap: [Character:Character] = [:]
        
        let sArray = Array(s)
        let tArray = Array(t)
        
        for (index, sChar) in sArray.enumerated() {
            let tChar = tArray[index]
            
            if sHashMap[sChar] == nil && tHashMap[tChar] == nil {
                sHashMap[sChar] = tChar
                tHashMap[tChar] = sChar
            } else if (sHashMap[sChar] != tChar) || (tHashMap[tChar] != sChar) {
                return false
            }
        }
        
        return true
    }
}