// https://leetcode.com/problems/perfect-squares

class Solution {
    var dpCache = [0:0, 1:1]
    
    func numSquares(_ n: Int) -> Int {
        if n < 0 { return Int.max }
        if let cacheValue = dpCache[n] { return cacheValue }
        
        var minSquareCount = Int.max
        
        for currentNumber in 1...n {
            let currentNumberSquare = currentNumber*currentNumber
            let possibleAnswer = numSquares(n-currentNumberSquare)
            minSquareCount = min(minSquareCount, possibleAnswer)
        }
        
        dpCache[n] = minSquareCount+1
        return dpCache[n]!
    }
}