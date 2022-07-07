// https://leetcode.com/problems/finding-the-users-active-minutes

class Solution {
    func findingUsersActiveMinutes(_ logs: [[Int]], _ k: Int) -> [Int] {
        var hashMap: [Int : Set<Int>] = [:]
        
        for log in logs {
            let id = log[0]
            
            var set = hashMap[id] ?? Set<Int>()
            set.insert(log[1])
            
            hashMap[id] = set
        }
        
        var output: [Int] = []
        for _ in 0..<k { output.append(0) }
        
        for (_, value) in hashMap {
            if value.count <= k {
                let index = value.count - 1
                let existingValue = output[index]
                
                output[index] = existingValue + 1
            } 
        }
        
        return output
    }
}