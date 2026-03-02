class Solution {
    /// -----------------------------------------------------------------------
    /// Problem Summary:
    ///   Given an n x n binary grid, rearrange rows using adjacent swaps so that
    ///   for every row i:
    ///
    ///       the rightmost '1' in that row is at index ≤ i.
    ///
    ///   Return the minimum number of adjacent swaps required.
    ///   If impossible, return -1.
    ///
    /// Strategy (Greedy + Single Pass Simulation):
    ///   1. For each row, compute the index of its rightmost '1'.
    ///      If a row has no '1', treat it as -1 (always valid).
    ///
    ///   2. Iterate row by row:
    ///        - If current row already satisfies condition, continue.
    ///        - Otherwise, find the nearest row below that satisfies it.
    ///        - Bubble that row upward using adjacent swaps.
    ///
    ///   This greedy strategy is optimal because:
    ///     - Bringing the nearest valid row minimizes swaps.
    ///     - Any farther row would strictly increase operations.
    ///
    /// Time Complexity:
    ///   O(n²)
    ///     - Computing rightmost indices: O(n²)
    ///     - Greedy simulation: worst-case O(n²)
    ///
    ///   Note: O(n²) is optimal since the input itself has n² elements.
    ///
    /// Space Complexity:
    ///   O(n)
    ///     - Stores rightmost index per row.
    /// -----------------------------------------------------------------------
    
    func minSwaps(_ grid: [[Int]]) -> Int {
        let size = grid.count
        var swapCount = 0
        
        // Compute rightmost '1' index for each row
        var rightmostOneIndex: [Int] = grid.map { row in
            row.lastIndex(where: { $0 == 1 }) ?? -1
        }
        
        // Greedy row-by-row placement
        for currentRow in 0..<size {
            // If already valid, continue
            if rightmostOneIndex[currentRow] <= currentRow {
                continue
            }
            
            // Find nearest valid row below
            var candidateRow = currentRow + 1
            while candidateRow < size && rightmostOneIndex[candidateRow] > currentRow {
                candidateRow += 1
            }
            
            // No valid row found → impossible
            if candidateRow == size {
                return -1
            }
            
            // Bubble the candidate row upward
            while candidateRow > currentRow {
                rightmostOneIndex.swapAt(candidateRow, candidateRow - 1)
                swapCount += 1
                candidateRow -= 1
            }
        }
        
        return swapCount
    }
}