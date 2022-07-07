// https://leetcode.com/problems/power-of-two

class Solution {
    func isPowerOfTwo(_ n: Int) -> Bool {
        if n == 1 { return true }
        if n <= 0 { return false }
        if n % 2 == 1 { return false }
        
        return isPowerOfTwo(n/2)
    }
}