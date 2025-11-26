/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(rows * cols * k)
///     For each cell (row, col) and each remainder ∈ [0, k), we compute at most
///     one DFS result thanks to memoization.
///
/// Space Complexity:
///   • O(rows * cols * k) for memo
///   • O(rows + cols) recursion stack
///
/// Description:
///   We count the number of valid paths from (0, 0) to (rows-1, cols-1)
///   moving only DOWN or RIGHT. We track the running sum modulo k,
///   because only the remainder matters for divisibility.
///   Memoization is used to avoid recomputation of identical states.
/// ---------------------------------------------------------------------------

class Solution {
    func numberOfPaths(_ grid: [[Int]], _ k: Int) -> Int {
        let rows = grid.count
        let cols = grid[0].count
        let mod = 1_000_000_007
        
        // Memoization: (row, col, remainder) → number of valid paths
        var memo = [[Int]: Int]()
        
        /// DFS from a given cell tracking the current remainder of the path sum.
        func dfs(_ row: Int, _ col: Int, _ currentRemainder: Int) -> Int {
            // Out of bounds → no path
            if row >= rows || col >= cols { return 0 }
            
            // Update remainder after including current cell value
            let newRemainder = (currentRemainder + grid[row][col]) % k
            
            // If at destination, check divisibility
            if row == rows - 1 && col == cols - 1 { return newRemainder == 0 ? 1 : 0 }
            
            // Return memoized result if already computed
            if let cached = memo[[row, col, newRemainder]] { return cached }
            
            // Explore downward and rightward paths
            var totalPaths = 0
            
            totalPaths += dfs(row + 1, col, newRemainder)
            totalPaths %= mod
            
            totalPaths += dfs(row, col + 1, newRemainder)
            totalPaths %= mod
            
            // Store computed result
            memo[[row, col, newRemainder]] = totalPaths
            return totalPaths
        }
        
        return dfs(0, 0, 0)
    }
}
