class Solution {
    /// -----------------------------------------------------------------------
    /// Problem Summary:
    ///   Determine whether the binary representation of `n`
    ///   contains alternating bits (e.g., 101010...).
    ///
    /// Time Complexity:
    ///   • O(log n)
    ///     We examine each bit of `n` once.
    ///
    /// Space Complexity:
    ///   • O(1)
    ///     Only a few integer variables are used.
    ///
    /// Approach:
    ///   - Extract the least significant bit repeatedly.
    ///   - Compare it with the previous bit.
    ///   - If two consecutive bits are the same, return false.
    /// -----------------------------------------------------------------------
    func hasAlternatingBits(_ n: Int) -> Bool {
        var value = n
        var previousBit = -1
        
        while value > 0 {
            let currentBit = value % 2  // Extract last bit
            
            // If two consecutive bits are equal → not alternating
            if currentBit == previousBit {
                return false
            }
            
            previousBit = currentBit
            value /= 2  // Shift right
        }
        
        return true
    }
}