// https://leetcode.com/problems/egg-drop-with-2-eggs-and-n-floors

class Solution {
    // Dynamic programming - MCM concept
    func twoEggDrop(_ n: Int) -> Int {
        var dpCache = Array(repeating: Array(repeating: -1, count: n+1), count: 3)
        
        func findMinMoves(_ eggCount: Int, _ floorsCount: Int) -> Int {
            // Base cases
            if floorsCount == 0 || floorsCount == 1 { return floorsCount } 
            if eggCount == 1 { return floorsCount } 
            
            // check result in cache first...to avoid expensive recersive-calls
            let cacheValue = dpCache[eggCount][floorsCount] 
            if cacheValue != -1 { return cacheValue }
            
            // Find min moves using MCM concept
            var minMoves = Int.max
            for k in 1...floorsCount {
                let eggBrokCaseCount = findAndCacheMinMoves(eggCount-1, k-1)
                let eggNotBrokCaseCount = findAndCacheMinMoves(eggCount, floorsCount-k)
                let tempAnswer = 1 + max(eggBrokCaseCount, eggNotBrokCaseCount)
                
                minMoves = min(minMoves, tempAnswer) 
            }
            
            // Update cache
            dpCache[eggCount][floorsCount] = minMoves
            
            return minMoves
        }
        
        func findAndCacheMinMoves(_ eggCount: Int, _ floorsCount: Int) -> Int {
            let movesCount: Int
            
            // check result in cache first...to avoid expensive recersive-calls
            let cacheValue = dpCache[eggCount][floorsCount] 
            if cacheValue != -1 { 
                movesCount = cacheValue 
            } else {
                movesCount = findMinMoves(eggCount, floorsCount)
                dpCache[eggCount][floorsCount] = movesCount
            }
            
            return movesCount
        }
    
        return findMinMoves(2, n)
    }
}