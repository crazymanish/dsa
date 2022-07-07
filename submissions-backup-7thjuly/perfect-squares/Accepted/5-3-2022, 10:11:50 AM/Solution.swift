// https://leetcode.com/problems/perfect-squares

class Solution {
    func numSquares(_ n: Int) -> Int {
        var dpCache = Array(repeating: 0, count: n+1)
        
        for currentNumber in 1...n {
            var minSquareCount = Int.max
            
            for currentSquareNumber in 1...currentNumber {
                let currentSquare = currentSquareNumber*currentSquareNumber
                
                if currentSquare > currentNumber { break }
                
                let remainingNumber = currentNumber-currentSquare
                minSquareCount = min(minSquareCount, dpCache[remainingNumber])
            }
            
            dpCache[currentNumber] = minSquareCount+1
        }
        
        return dpCache[n]
    }
}