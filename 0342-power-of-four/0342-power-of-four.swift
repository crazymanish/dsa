class Solution {
    func isPowerOfFour(_ n: Int) -> Bool {
        if n == 1 { return true } // i.e 4° = 1
        if n <= 0 { return false } // i.e 0 or negative value
        if n % 4 == 1 { return false } // i.e 5/4 scenarios
        if n % 4 == 2 { return false } // i.e 6/4 scenarios
        if n % 4 == 3 { return false } // i.e 7/4 scenarios
        return isPowerOfFour(n/4)
    }
}