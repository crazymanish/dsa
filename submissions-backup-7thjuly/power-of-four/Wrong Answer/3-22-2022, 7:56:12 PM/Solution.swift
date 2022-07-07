// https://leetcode.com/problems/power-of-four

class Solution {
    func isPowerOfFour(_ n: Int) -> Bool {
        if n == 1 { return true } // i.e 4° = 1
        if n <= 0 { return false } // i.e 0 or negative value
        if n % 4 == 1 { return false } // i.e 5/4 scenarios

        return isPowerOfFour(n/4)
    }
}