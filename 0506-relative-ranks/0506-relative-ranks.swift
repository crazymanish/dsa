class Solution {
    func findRelativeRanks(_ score: [Int]) -> [String] {
        var answer = Array(repeating: "", count: score.count)
        let sortedScore = score.enumerated().sorted{ $0.1 > $1.1 }
        
        for i in 0..<sortedScore.count {
            if i == 0 { answer[sortedScore[i].0] = "Gold Medal" }
            if i == 1 { answer[sortedScore[i].0] = "Silver Medal" }
            if i == 2 { answer[sortedScore[i].0] = "Bronze Medal" }
            if i >= 3 { answer[sortedScore[i].0] = String(i+1) }
        }
        
        return answer
    }
}