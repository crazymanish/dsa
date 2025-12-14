class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(n), where n = corridor.count
    ///     We scan the string once.
    ///
    /// Space Complexity:
    ///   • O(1)
    ///     Only a small number of integer counters are used.
    ///
    /// Problem Summary:
    ///   A valid configuration splits the corridor into sections, where each
    ///   section contains **exactly two seats ('S')** and any number of plants ('P').
    ///
    /// Core Insight:
    ///   Every time we complete a seat-pair (i.e., seat count goes from 2k → 2k+1),
    ///   the number of ways to place a divider is:
    ///
    ///       (plantsBetweenSeatPairs + 1)
    ///
    ///   because you may place the divider:
    ///     - before the first plant,
    ///     - between any plants,
    ///     - or after the last plant.
    ///
    ///   Multiply these choices across all seat-pair transitions.
    /// -----------------------------------------------------------------------
    func numberOfWays(_ corridor: String) -> Int {
        let mod = 1_000_000_007
        
        var ways = 1
        var plantCount = 0
        var seatCount = 0
        
        for ch in corridor {
            if ch == "P" {
                // Count plants between valid seat-pairs
                plantCount += 1
                continue
            }
            
            // We have encountered a seat
            seatCount += 1
            
            // When seatCount transitions to an odd number > 1, we just
            // started a new seat-pair and the previous one is closed.
            //
            // Example:
            //   S  P  P  S  |  S  P  S
            //      ↑ plants counted here
            //
            // There are (plantCount + 1) choices for placing a divider.
            if seatCount > 1, seatCount % 2 == 1 {
                ways = (ways * (plantCount + 1)) % mod
            }
            
            // Reset plant counter because we only count plants between pairs
            plantCount = 0
        }
        
        // Must have a positive, even number of seats to form valid pairs
        guard seatCount > 0, seatCount % 2 == 0 else { return 0 }
        
        return ways
    }
}
