// https://leetcode.com/problems/find-the-highest-altitude

class Solution {
    func largestAltitude(_ gain: [Int]) -> Int {
        var largestAltitude = 0
        var currentAltitude = 0
        
        for gainValue in gain {
            currentAltitude += gainValue
            
            largestAltitude = max(largestAltitude, currentAltitude)
        }
        
        return largestAltitude
    }
}