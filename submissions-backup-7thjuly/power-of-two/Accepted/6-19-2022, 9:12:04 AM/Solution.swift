// https://leetcode.com/problems/power-of-two

class Solution {
    func isPowerOfTwo(_ n: Int) -> Bool {
        if n == 1 { return true } // i.e 2° = 1
        if n <= 0 { return false } // i.e 0 or negative value
        if n % 2 == 1 { return false } // i.e 3/2 scenarios
        
        return isPowerOfTwo(n/2)
    }
}