// https://leetcode.com/problems/word-pattern

class Solution {
    func wordPattern(_ pattern: String, _ s: String) -> Bool {
        let patternArray = Array(pattern)
        let sArray = s.components(separatedBy: " ")
        
        guard patternArray.count == sArray.count else { return false }
        
        var patternHashMap: [Character: String] = [:]
        var sHashMap: [String: Character] = [:]
        
        for (index, patternChar) in patternArray.enumerated() {
            let sString = sArray[index]

            if patternHashMap[patternChar] == nil && sHashMap[sString] == nil {
                patternHashMap[patternChar] = sString
                sHashMap[sString] = patternChar
            } else if (patternHashMap[patternChar] != sString) || (sHashMap[sString] != patternChar) {
                return false
            }
        }

        return true
    }
}