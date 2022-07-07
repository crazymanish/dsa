// https://leetcode.com/problems/power-of-three

class Solution {
    func isPowerOfThree(_ n: Int) -> Bool {
        if n == 1 { return true } // i.e 3° = 1
        if n <= 0 { return false } // i.e 0 or negative value
        if n % 3 == 1 { return false } // i.e 4/3 scenarios
        if n % 3 == 2 { return false } // i.e 5/3 scenarios

        return isPowerOfThree(n/4)
    }
}