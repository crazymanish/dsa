// Time Complexity: O(1)
// This solution involves a few bitwise and comparison operations, which are
// executed in constant time, regardless of the magnitude of n.
//
// Space Complexity: O(1)
// No extra space that scales with the input is used.
class Solution {
    func isPowerOfFour(_ n: Int) -> Bool {
        // A number `n` is a power of four if it meets three conditions:
        
        // Condition 1: `n > 0`
        // Powers of four must be positive.
        guard n > 0 else { return false }
        
        // Condition 2: `(n & (n - 1)) == 0`
        // This is a classic trick to check if `n` is a power of two.
        // A power of four must also be a power of two (since 4 = 2^2).
        // In binary, a power of two has exactly one bit set to '1'.
        guard (n & (n - 1)) == 0 else { return false }
        
        // Condition 3: `(n & 0x55555555) != 0` (for 32-bit integers)
        // Among powers of two, powers of four have their single '1' bit
        // in an even-numbered position (0th, 2nd, 4th, etc.).
        // - 4^0 = 1 (0001) -> bit at position 0
        // - 4^1 = 4 (0100) -> bit at position 2
        // - 4^2 = 16 (0001 0000) -> bit at position 4
        // The hexadecimal number 0x55555555 is a bitmask `01010101...` which
        // has '1's only in the even positions. ANDing with this mask will be non-zero
        // if and only if the single '1' bit in `n` is in one of those even positions.
        return (n & 0x55555555) != 0
    }
}