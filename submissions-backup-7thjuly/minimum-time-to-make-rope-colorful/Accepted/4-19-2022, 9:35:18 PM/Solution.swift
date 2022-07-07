// https://leetcode.com/problems/minimum-time-to-make-rope-colorful

class Solution {
    func minCost(_ colors: String, _ neededTime: [Int]) -> Int {
        let colorsArray = Array(colors)
        let colorsArrayCount = colorsArray.count
        
        if colorsArrayCount == 1 { return 0 }
        
        var previousMax = 0
        var minCost = 0
        
        for index in 1..<colorsArrayCount {
            if colorsArray[index-1] == colorsArray[index] {
                let maxValue = max(neededTime[index-1], previousMax)
                let minValue = min(maxValue, neededTime[index])
                
                minCost += minValue
                previousMax = maxValue
            } else {
                previousMax = 0
            } 
        }
        
        return minCost
    }
}