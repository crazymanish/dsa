class Solution {
    /// -----------------------------------------------------------------------
    /// Problem Summary:
    ///   Given a positive integer `n`, return the maximum distance
    ///   between two consecutive 1 bits in its binary representation.
    ///
    ///   The distance is the difference between their positions.
    ///
    /// Example:
    ///   n = 22 → binary "10110"
    ///   1's at positions: 0, 2, 3 → max gap = 2
    ///
    /// Time Complexity:
    ///   • O(log n)
    ///     We examine each bit once.
    ///
    /// Space Complexity:
    ///   • O(1)
    ///     Only a few integer variables are used.
    /// -----------------------------------------------------------------------
    func binaryGap(_ n: Int) -> Int {
        var value = n
        var bitPosition = 0
        var previousOnePosition = -1
        var maxDistance = 0
        
        // Traverse bits from least significant to most significant
        while value > 0 {
            
            // If current bit is 1
            if (value & 1) == 1 {
                
                // If we've seen a 1 before, compute distance
                if previousOnePosition != -1 {
                    maxDistance = max(maxDistance, bitPosition - previousOnePosition)
                }
                
                previousOnePosition = bitPosition
            }
            
            // Move to next bit
            value >>= 1
            bitPosition += 1
        }
        
        return maxDistance
    }
}
