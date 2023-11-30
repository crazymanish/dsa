class Solution {
    func minimumOneBitOperations(_ n: Int) -> Int {
        var answer = 0
        var mask = 1
        
        while mask <= n {
            if n & mask != 0 {
                answer = (mask*2 - 1) - answer
            }
            
            mask <<= 1
        }
        
        return answer
    }
}