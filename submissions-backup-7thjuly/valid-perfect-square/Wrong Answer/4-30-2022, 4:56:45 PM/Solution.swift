// https://leetcode.com/problems/valid-perfect-square

class Solution {
    func isPerfectSquare(_ num: Int) -> Bool {
        var mutableNum = num
        var isPerfectSquare = true
        
        while mutableNum > 2 {
             if mutableNum % 2 != 0 {
                 isPerfectSquare = false
                 break
             }
            
            mutableNum /= 2
        }
        
        if mutableNum == 2 { isPerfectSquare = false }
        
        return isPerfectSquare
    }
}