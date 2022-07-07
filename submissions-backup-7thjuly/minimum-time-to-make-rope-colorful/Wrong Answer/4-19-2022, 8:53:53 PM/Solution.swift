// https://leetcode.com/problems/minimum-time-to-make-rope-colorful

class Solution {
    func minCost(_ colors: String, _ neededTime: [Int]) -> Int {
        let colorsArray = Array(colors)
        let colorsArrayCount = colorsArray.count
        
        if colorsArrayCount == 1 { return 0 }
        
        var output = 0
        
        for index in 1..<colorsArrayCount {
            if colorsArray[index-1] == colorsArray[index] {
                output += min(neededTime[index-1], neededTime[index])
            } 
        }
        
        return output
    }
}