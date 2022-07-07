// https://leetcode.com/problems/evaluate-the-bracket-pairs-of-a-string

class Solution {
    func evaluate(_ s: String, _ knowledge: [[String]]) -> String {
        var hashMap: [String : String] = [:]
        for pair in knowledge { hashMap[pair[0]] = pair[1] }
        
        var outputString = ""
        
        var currentBracket = ""
        var shouldAppend = true
        for char in s.reversed() {
            if char == ")" {
                shouldAppend = false
                currentBracket = ""
            } else if char == "(" {
                shouldAppend = true
                let replacingString = hashMap[currentBracket] ?? "?"
                outputString = replacingString + outputString
            } else {
                currentBracket = String(char) + currentBracket
                if shouldAppend { outputString = String(char) + outputString }
            }
        }
        
        return outputString
    }
}