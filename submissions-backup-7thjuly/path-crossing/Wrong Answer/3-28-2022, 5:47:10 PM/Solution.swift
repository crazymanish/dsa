// https://leetcode.com/problems/path-crossing

class Solution {
    func isPathCrossing(_ path: String) -> Bool {
        var hasMap: [Character : Bool] = [:]
        
        var isPathCrossing = false 
        
        for char in path {
            if hasMap[char] == nil {
                hasMap[char] = true
            } else {
                isPathCrossing = true
                break
            }
        }
        
        return isPathCrossing
    }
}