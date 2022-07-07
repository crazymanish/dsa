// https://leetcode.com/problems/count-the-number-of-consistent-strings

class Solution {
    func countConsistentStrings(_ allowed: String, _ words: [String]) -> Int {
        typealias CharIsExistMap = [Character : Bool]
        var hashMap: CharIsExistMap = [:]

        for char in allowed {
            hashMap[char] = true
        }

        var output = 0
        for word in words {
            var isInConsistentCharFound = false
            for char in word {
                if hashMap[char] == nil { 
                    isInConsistentCharFound = true
                    break 
                }
            }
            
            if isInConsistentCharFound == false { output += 1 }
        }

        return output
    }
}