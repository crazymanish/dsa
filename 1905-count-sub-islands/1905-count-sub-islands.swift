class Solution {
    func countSubIslands(_ grid1: [[Int]], _ grid2: [[Int]]) -> Int {
        let (m, n) = (grid1.count, grid1[0].count)
        var grid2 = grid2
        var res = 0
        var island = [[Int]]()
        
        // Recursively find the island.
        func dfs(_ r: Int, _ c: Int) {
            // Make sure the cell is within the grid bounds.
            guard (0..<m).contains(r) && (0..<n).contains(c) else { return }
            
            // Make sure the cell hasn't been visited.
            guard grid2[r][c] == 1 else { return }

            // Add cell to the island and mark it as visited.
            island.append([r, c])
            grid2[r][c] = 2

            // Visit adjacent cells.
            for (dr, dc) in [(1, 0), (-1, 0), (0, 1), (0, -1)] {
                dfs(r + dr, c + dc)
            }
        }

        // Go through every cell that hasn't been visited yet.
        for r in 0..<m {
            for c in 0..<n where grid2[r][c] == 1 {
                // Find the island, if any, that contains the cell.
                island = [[Int]]()
                dfs(r, c)

                // Make sure the island is a sub island of the first grid.
                res += island.allSatisfy { grid1[$0[0]][$0[1]] == 1 } ? 1 : 0
            }
        }
        
        return res
    }
}