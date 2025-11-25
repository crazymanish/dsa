/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(k) in the worst case
///     Each iteration computes (value * 10 + 1) % k.
///     Since there are only k possible remainders (0 to k–1), the loop runs
///     at most k times before hitting remainder 0.
///
/// Space Complexity:
///   • O(1)
///     Only constant extra integers are used.
///
/// Description:
///   We are building a repunit:
///       1, 11, 111, 1111, ...
///   Instead of constructing the actual number (which would overflow), we keep
///   track of the remainder modulo k:
///
///       remainderₙ = (remainderₙ₋₁ * 10 + 1) % k
///
///   When remainder becomes 0, the current length is the desired answer.
///
///   A repunit divisible by k exists *only if* k is NOT divisible by 2 or 5.
/// ---------------------------------------------------------------------------

class Solution {
    func smallestRepunitDivByK(_ k: Int) -> Int {
        // If k is divisible by 2 or 5, no repunit can be divisible by k
        if k % 2 == 0 || k % 5 == 0 {
            return -1
        }
        
        // Start with the first repunit: "1"
        var remainder = 1 % k
        var length = 1
        
        // Continue generating repunits until divisible
        while remainder != 0 {
            remainder = (remainder * 10 + 1) % k
            length += 1
        }
        
        return length
    }
}
