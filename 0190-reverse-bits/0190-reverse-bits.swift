class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(1)
    ///     Always processes exactly 32 bits.
    ///
    /// Space Complexity:
    ///   • O(1)
    ///     Only a few integer variables are used.
    ///
    /// Problem Summary:
    ///   Reverse the bits of a 32-bit integer.
    ///
    /// Approach:
    ///   - Extract the least significant bit one by one.
    ///   - Shift result left and append extracted bit.
    ///   - Repeat 32 times.
    /// -----------------------------------------------------------------------
    func reverseBits(_ n: Int) -> Int {
        var input = n
        var reversed = 0
        
        for _ in 0..<32 {
            // Shift result left to make space
            reversed <<= 1
            
            // Append last bit of input
            reversed |= (input & 1)
            
            // Shift input right
            input >>= 1
        }
        
        return reversed
    }
}