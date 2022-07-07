// https://leetcode.com/problems/shortest-distance-to-a-character

class Solution {
    func shortestToChar(_ s: String, _ c: Character) -> [Int] {
        let sArray = Array(s)
        let sCount = sArray.count
        
        var leftPointer = 0
        var rightPointer = sCount-1
        var output: [Int] = []
        
        var lastClosestDistance = Int.max-sCount
        
        while leftPointer < sCount {
            if sArray[leftPointer] == c { 
                lastClosestDistance = 0 
            } else {
                lastClosestDistance += 1
            }
            
            output.append(lastClosestDistance)
            
            leftPointer += 1
        }
        
        lastClosestDistance = Int.max-sCount
        
        while rightPointer >= 0 {
            if sArray[rightPointer] == c { 
                lastClosestDistance = 0 
            } else {
                lastClosestDistance += 1
            }
            
            lastClosestDistance = min(lastClosestDistance, output[rightPointer])
            
            output[rightPointer] = lastClosestDistance
            
            rightPointer -= 1
        }
        
        return output
    }
}