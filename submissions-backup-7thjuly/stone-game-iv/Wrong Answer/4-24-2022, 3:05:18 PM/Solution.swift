// https://leetcode.com/problems/stone-game-iv

class Solution {
    func winnerSquareGame(_ n: Int) -> Bool {
        func playStoneGame(_ n: Int) -> Int {
            if n < 1 { return 0 }
            
            let cacheValue = dpCache[n]
            if cacheValue != -1 { return cacheValue }
            
            let squareValue = findMaxPerfectSquareValueFor(n)
            let answer = 1 + playStoneGame(n-squareValue)
            
            dpCache[n] = answer
            return answer
        }
        
        func findMaxPerfectSquareValueFor(_ n: Int) -> Int {
            if n < 1 { return 0 }
            
            let cacheValue = perfectSquareDPCache[n]
            if cacheValue != -1 { return cacheValue }
            
            var currentSquareNumber = 1 
            while currentSquareNumber*currentSquareNumber < n {
                currentSquareNumber += 1
            }

            var answer = currentSquareNumber*currentSquareNumber
            if answer > n {
                answer = (currentSquareNumber-1)*(currentSquareNumber-1)
            }
            
            perfectSquareDPCache[n] = answer
            return answer
        }
        
        var dpCache = Array(repeating: -1, count: n+1)
        var perfectSquareDPCache = Array(repeating: -1, count: n+1)
        
        let totalMoves = playStoneGame(n)
        return totalMoves % 2 != 0 // Alice wins only if total moves are ODD
    }
}