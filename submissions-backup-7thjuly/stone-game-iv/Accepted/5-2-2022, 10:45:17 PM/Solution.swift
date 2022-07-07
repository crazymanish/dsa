// https://leetcode.com/problems/stone-game-iv

class Solution {
    func winnerSquareGame(_ n: Int) -> Bool {
        func playStoneGame(_ n: Int) -> Bool {
            if n < 1 { return false }
            
            if let cacheValue = dpCache[n] { return cacheValue }
            
            var canIWin = false
            
            var currentSquareNumber = 1 
            while currentSquareNumber*currentSquareNumber <= n {
                let squareValue = currentSquareNumber*currentSquareNumber
                let canNextPlayerWin = playStoneGame(n-squareValue)
                
                if canNextPlayerWin == false { 
                    canIWin = true 
                    break
                }
                
                currentSquareNumber += 1
            }
            
            dpCache[n] = canIWin
            return canIWin
        }
        
        var dpCache: [Bool?] = Array(repeating: nil, count: n+1)
        
        return playStoneGame(n)
    }
}