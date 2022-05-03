class Solution {
    func integerBreak(_ n: Int) -> Int {
        var dpCache = [1:1]
        
        for currentNumber in 2...n {
            // we need to break integer only if currentNumber == n
            dpCache[currentNumber] = currentNumber == n ? 0 : currentNumber
            
            for index in 1..<currentNumber {
                let sum = dpCache[index]! * dpCache[currentNumber-index]!
                dpCache[currentNumber] = max(dpCache[currentNumber]!, sum)
            }
        }
        
        return dpCache[n]!
    }
}