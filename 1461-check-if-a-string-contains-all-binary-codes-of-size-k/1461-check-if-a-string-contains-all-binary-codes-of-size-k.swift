class Solution {
    /// -----------------------------------------------------------------------
    /// Problem Summary:
    ///   Given a binary string `s` and integer `k`,
    ///   determine whether every possible binary code of length `k`
    ///   appears as a substring of `s`.
    ///
    ///   There are exactly 2^k possible binary codes of length k.
    ///
    /// Strategy:
    ///   - Use a rolling hash to represent each k-length substring.
    ///   - Maintain a boolean array to track which codes have appeared.
    ///   - Use a bitmask to ensure the rolling hash keeps only k bits.
    ///   - Stop early if all 2^k codes are found.
    ///
    /// Time Complexity:
    ///   • O(n)
    ///     Each character is processed once.
    ///
    /// Space Complexity:
    ///   • O(2^k)
    ///     Boolean array storing seen codes.
    /// -----------------------------------------------------------------------
    func hasAllCodes(_ s: String, _ k: Int) -> Bool {
        
        // Total number of possible k-bit binary codes
        var remainingCodes = 1 << k
        
        // Track which codes we've seen
        var seenCodes = Array(repeating: false, count: remainingCodes)
        
        // Bitmask to keep only the last k bits
        let bitmask = remainingCodes - 1
        
        var rollingHash = 0
        let characters = Array(s)
        
        for index in 0..<characters.count {
            
            // Shift left by 1, keep only k bits, add new bit
            rollingHash = ((rollingHash << 1) & bitmask)
                | Int(characters[index].asciiValue! - Character("0").asciiValue!)
            
            // Only start checking once we have at least k characters
            if index >= k - 1 && !seenCodes[rollingHash] {
                seenCodes[rollingHash] = true
                remainingCodes -= 1
                
                // If all codes found, return early
                if remainingCodes == 0 {
                    return true
                }
            }
        }
        
        return false
    }
}