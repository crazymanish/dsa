// https://leetcode.com/problems/rank-teams-by-votes

class Solution {
    func rankTeams(_ votes: [String]) -> String {
        var hashMap: [Character : [Int]] = [:]
        let teams = votes[0].count
        
        for vote in votes {
            for (index, char) in vote.enumerated() {
                var hashMapValue = hashMap[char] ?? Array(repeating: 0, count: teams)
                hashMapValue[index] += 1
                hashMap[char] = hashMapValue
            }
        }
        
        var outputCharacters = hashMap.keys.sorted {
            for index in 0..<teams {
                let leftValue = hashMap[$0]![index]
                let rightValue = hashMap[$1]![index]
                
                if leftValue != rightValue {
                    return leftValue > rightValue
                }
            }
            
            return $0 < $1
        }
        
        return String(outputCharacters)
    }
}