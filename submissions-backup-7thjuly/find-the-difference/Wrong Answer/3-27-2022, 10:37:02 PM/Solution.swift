// https://leetcode.com/problems/find-the-difference

class Solution {
    func findTheDifference(_ s: String, _ t: String) -> Character {
        let hashMapS = hashMap(s)
        let hashMapT = hashMap(t)
        
        var outputChar: Character = "0"
        
        for (key, value) in hashMapT {
            if hashMapS[key] == nil {
                outputChar = key
                break
            }
        }
        
        return outputChar
    }
    
    private func hashMap(_ text: String) -> [Character : Bool] {
        var hashMap: [Character : Bool] = [:]
        
        for char in text { hashMap[char] = true }
        
        return hashMap
    }
}