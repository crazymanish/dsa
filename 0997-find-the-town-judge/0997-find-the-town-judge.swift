class Solution {
    func findJudge(_ n: Int, _ trusts: [[Int]]) -> Int {
        var hashMap: [Int : [Int]] = [:]
        
        for people in 1...n { hashMap[people] = [] }
        
        for trust in trusts {
            hashMap[trust[0]] = (hashMap[trust[0]] ?? []) + [trust[1]]
        }
        
        var possibleJudge = -1
        for (key, value) in hashMap {
            if value.isEmpty {
                possibleJudge = key
                break
            }
        }
        
        if possibleJudge != -1 {
            for (key, value) in hashMap {
                if key == possibleJudge { continue }
                
                if value.contains(possibleJudge) == false {
                    possibleJudge = -1
                    break
                }
            }
        }
        
        return possibleJudge
    }
}