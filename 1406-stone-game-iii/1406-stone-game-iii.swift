class Solution {
    func stoneGameIII(_ piles: [Int]) -> String {
        func playStoneGame(startIndex: Int) -> Int {
            if startIndex > pilesCount { return 0 }
            
            let cacheValue = dpCache[startIndex]
            if cacheValue != -1 { return cacheValue }
            
            var sum = 0
            var answer = Int.min
            for X in 1...3 {
                let currentIndex = startIndex+X-1
                if currentIndex < pilesCount { sum += piles[currentIndex] }
                
                let possibleAnswer = sum - playStoneGame(startIndex: currentIndex+1)
                answer = max(answer, possibleAnswer)
            }
            
            dpCache[startIndex] = answer
            return answer
        }
        
        let pilesCount = piles.count
        var dpCache = Array(repeating: -1, count: pilesCount+1)
        
        var totalStones = 0 // A+B
        for stone in piles { totalStones += stone }
        
        let diffOfAliceAndBobStones = playStoneGame(startIndex: 0) // A-B
        
        // Logic is: (A+B)+(A-B) => 2A/2 ==> A (Alice) 
        let aliceScore = (totalStones+diffOfAliceAndBobStones) / 2
        let bobScore = (totalStones-aliceScore)
        
        if aliceScore > bobScore { return "Alice" } 
        else if aliceScore < bobScore { return "Bob" } 
        else { return "Tie" } 
    }
}