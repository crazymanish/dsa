// https://leetcode.com/problems/stone-game-vii

class Solution {
    func stoneGameVII(_ stones: [Int]) -> Int {
        func playStoneGame(_ startIndex: Int, _ endIndex: Int) -> Int {
            if startIndex >= endIndex { return 0 }
            
            var totalValue = 0
            for index in startIndex...endIndex { totalValue += stones[index] }
            
            let cacheValue = dpCache[startIndex][endIndex]
            if cacheValue != -1 { return cacheValue }
            
            // Let's assume that Alice will pick startIndex
            let possibleAnswer1 = (totalValue - stones[startIndex]) - playStoneGame(startIndex+1, endIndex)
            
            // Let's assume that Alice will pick endIndex
            let possibleAnswer2 = (totalValue - stones[endIndex]) - playStoneGame(startIndex, endIndex-1)
            
            let answer = max(possibleAnswer1, possibleAnswer2)
            
            dpCache[startIndex][endIndex] = answer
            return answer
        }
        
        let stonesCount = stones.count
        var dpCache = Array(repeating: Array(repeating: -1, count: stonesCount+1), count: stonesCount+1)
        
        return playStoneGame(0, (stonesCount-1))
    }
}