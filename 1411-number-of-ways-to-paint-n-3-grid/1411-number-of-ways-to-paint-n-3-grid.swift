class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(n)
    ///     We iterate once for each row of the grid.
    ///
    /// Space Complexity:
    ///   • O(1)
    ///     Only a constant number of variables are used.
    ///
    /// Problem Summary:
    ///   We are painting an n x 3 grid using 3 colors.
    ///   Adjacent cells (horizontally or vertically) must have different colors.
    ///
    /// Key Insight:
    ///   For each row, there are only TWO valid pattern types:
    ///
    ///   Type 0 (ABC pattern):
    ///     - All three cells have different colors (e.g., R G B)
    ///     - Number of such patterns per row = 6
    ///
    ///   Type 1 (ABA pattern):
    ///     - First and third cells have the same color (e.g., R G R)
    ///     - Number of such patterns per row = 6
    ///
    ///   Let:
    ///     type0 = number of ways the current row is Type 0
    ///     type1 = number of ways the current row is Type 1
    ///
    /// Transition rules:
    ///     - New Type 0 can be formed from:
    ///         • 2 * previous Type 0
    ///         • 2 * previous Type 1
    ///
    ///     - New Type 1 can be formed from:
    ///         • 2 * previous Type 0
    ///         • 3 * previous Type 1
    ///
    ///   These transitions ensure vertical color constraints are satisfied.
    /// -----------------------------------------------------------------------
    func numOfWays(_ n: Int) -> Int {
        let MOD = 1_000_000_007
        
        // Base case for the first row:
        // There are 6 ABC patterns and 6 ABA patterns.
        var type0 = 6   // ABC
        var type1 = 6   // ABA
        
        // Build the grid row by row
        for _ in 1..<n {
            let prevType0 = type0
            let prevType1 = type1
            
            // Compute new values using transition rules
            type0 = (2 * prevType0 + 2 * prevType1) % MOD
            type1 = (2 * prevType0 + 3 * prevType1) % MOD
        }
        
        // Total number of valid ways
        return (type0 + type1) % MOD
    }
}
