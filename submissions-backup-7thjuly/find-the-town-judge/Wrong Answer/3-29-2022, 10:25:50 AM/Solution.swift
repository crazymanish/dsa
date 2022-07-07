// https://leetcode.com/problems/find-the-town-judge

class Solution {
    func findJudge(_ n: Int, _ trusts: [[Int]]) -> Int {
        var hashMap: [Int : Int] = [:]
        
        for people in 1...n { hashMap[people] = 0 }
        
        for trust in trusts {
            hashMap[trust[0]] = trust[1]
        }
        
        var judge = -1
        for (key, value) in hashMap {
            if value == 0 {
                judge = key
                break
            }
        }
        
        return judge
    }
}