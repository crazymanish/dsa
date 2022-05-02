class Solution {
    func stoneGame(_ piles: [Int]) -> Bool {
        func playStoneGame(_ startIndex: Int, _ endIndex: Int) -> Int {
            if startIndex > endIndex { return 0 }
            
            let cacheValue = dpCache[startIndex][endIndex]
            if cacheValue != -1 { return cacheValue }
            
            // Let's assume that Alice will pick startIndex
            let possibleAnswer1 = piles[startIndex] - playStoneGame(startIndex+1, endIndex)
            
            // Let's assume that Alice will pick endIndex
            let possibleAnswer2 = piles[endIndex] - playStoneGame(startIndex, endIndex-1)
            
            let answer = max(possibleAnswer1, possibleAnswer2)
            
            dpCache[startIndex][endIndex] = answer
            return answer
        }
        
        let pilesCount = piles.count
        var dpCache = Array(repeating: Array(repeating: -1, count: pilesCount+1), count: pilesCount+1)
        
        let diffOfAliceAndBobStones = playStoneGame(0, (pilesCount-1))
        return diffOfAliceAndBobStones > 0
    }
}