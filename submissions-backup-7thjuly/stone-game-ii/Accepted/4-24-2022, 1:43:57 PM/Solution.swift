// https://leetcode.com/problems/stone-game-ii

class Solution {
    func stoneGameII(_ piles: [Int]) -> Int {
        func playStoneGame(startIndex: Int, M: Int) -> Int {
            if startIndex > pilesCount { return 0 }
            
            let cacheValue = dpCache[startIndex][M]
            if cacheValue != -1 { return cacheValue }
            
            var sum = 0
            var answer = Int.min
            for X in 1...2*M {
                let currentIndex = startIndex+X-1
                if currentIndex < pilesCount { sum += piles[currentIndex] }
                
                let possibleAnswer = sum - playStoneGame(startIndex: currentIndex+1, M: max(M, X))
                answer = max(answer, possibleAnswer)
            }
            
            dpCache[startIndex][M] = answer
            return answer
        }
        
        let pilesCount = piles.count
        var dpCache = Array(repeating: Array(repeating: -1, count: 2*pilesCount+1), count: pilesCount+1)
        
        var totalStones = 0 // A+B
        for stone in piles { totalStones += stone }
        
        let diffOfAliceAndBobStones = playStoneGame(startIndex: 0, M: 1) // A-B
        
        // Logic is: (A+B)+(A-B) => 2A/2 ==> A (Alice) 
        return (totalStones+diffOfAliceAndBobStones) / 2 
    }
}