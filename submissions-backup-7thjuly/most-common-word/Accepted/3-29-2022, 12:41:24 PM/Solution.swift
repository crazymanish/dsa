// https://leetcode.com/problems/most-common-word

class Solution {
    func mostCommonWord(_ paragraph: String, _ banned: [String]) -> String {
        var text = paragraph.lowercased()
        text = text.replacingOccurrences(
            of: "[!?',;.]", 
            with: " ", 
            options: [.regularExpression])
        let words = text.components(separatedBy: " ")
        
        var hashMap: [String : Int] = [:]
        for word in words {
            let hashMapValue = hashMap[word] ?? 0
            hashMap[word] = hashMapValue + 1
        }
        
        hashMap[""] = -1
        
        for word in banned {
            hashMap[word] = -1
        }
        
        var mostCommonWord = ""
        var mostCommonWordTimes = Int.min
        
        for (key, value) in hashMap {
            if value > mostCommonWordTimes {
                mostCommonWordTimes = value
                mostCommonWord = key
            }
        }
        
        return mostCommonWord
    }
}