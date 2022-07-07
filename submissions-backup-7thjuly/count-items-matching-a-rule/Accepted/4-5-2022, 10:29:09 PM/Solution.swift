// https://leetcode.com/problems/count-items-matching-a-rule

class Solution {
    func countMatches(_ items: [[String]], _ ruleKey: String, _ ruleValue: String) -> Int {
        var output = 0
        
        for item in items {
            switch ruleKey {
                case "type": if ruleValue == item[0] { output += 1 }
                case "color": if ruleValue == item[1] { output += 1 }
                case "name": if ruleValue == item[2] { output += 1 }
                default: break
            }
        }
        
        return output
    }
}