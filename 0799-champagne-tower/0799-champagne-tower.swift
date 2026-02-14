class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(r²)
    ///     - r = query_row
    ///     We simulate each row up to query_row.
    ///
    /// Space Complexity:
    ///   • O(r²)
    ///     - 2D DP grid storing champagne amounts.
    ///
    /// Problem Summary:
    ///   Pour `poured` cups into the top glass.
    ///   Each glass holds at most 1 cup.
    ///   Any excess spills evenly to the two glasses below.
    ///
    ///   Return how full the glass at (query_row, query_glass) is.
    /// -----------------------------------------------------------------------
    func champagneTower(_ poured: Int, _ queryRow: Int, _ queryGlass: Int) -> Double {
        guard poured > 0 else { return 0.0 }
        
        // dp[row][glass] = amount of champagne in that glass
        var tower = [[Double(poured)]]
        
        // Build the tower row by row
        for currentRow in 0..<queryRow {
            
            // Prepare next row with zero-filled glasses
            tower.append(Array(repeating: 0.0, count: currentRow + 2))
            
            for glassIndex in 0..<tower[currentRow].count {
                let currentAmount = tower[currentRow][glassIndex]
                
                // If this glass overflows
                if currentAmount > 1.0 {
                    let overflow = (currentAmount - 1.0) / 2.0
                    
                    // Distribute overflow to next row
                    tower[currentRow + 1][glassIndex] += overflow
                    tower[currentRow + 1][glassIndex + 1] += overflow
                }
            }
        }
        
        // A glass can contain at most 1 unit
        return min(1.0, tower[queryRow][queryGlass])
    }
}