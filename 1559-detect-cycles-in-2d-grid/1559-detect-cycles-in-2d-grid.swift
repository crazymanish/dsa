/**
 Problem Summary:
 Given a 2D grid of characters, determine if there exists a cycle formed by
 adjacent cells (up, down, left, right) containing the same character.

 A valid cycle:
 - Must consist of the same character
 - Must have length ≥ 4
 - Cannot revisit the immediate parent cell

 Strategy:
 - Use DFS to explore connected components of the same character.
 - Keep a visited matrix to track explored cells.
 - During DFS:
     - Skip the parent cell (to avoid trivial backtracking).
     - If we reach a previously visited cell → cycle detected.
 - Define DFS as a nested function to avoid passing repetitive parameters.

 Time Complexity:
 O(rows * cols)

 Space Complexity:
 O(rows * cols) (visited + recursion stack)
 */
class Solution {
    func containsCycle(_ grid: [[Character]]) -> Bool {
        let rowCount = grid.count
        let colCount = grid[0].count
        
        // Tracks whether each cell has been visited
        var visited = Array(
            repeating: Array(repeating: false, count: colCount),
            count: rowCount
        )
        
        // 4-directional movement (down, up, right, left)
        let directions = [(1,0), (-1,0), (0,1), (0,-1)]
        
        /**
         DFS explores all connected cells of the same character.
         
         - Parameters:
           - row, col: current cell
           - parentRow, parentCol: previous cell to avoid immediate backtracking
           - targetChar: character defining the current component
         */
        func dfs(_ row: Int, _ col: Int, _ parentRow: Int, _ parentCol: Int, _ targetChar: Character) -> Bool {
            // Boundary check + ensure same character
            if row < 0 || row >= rowCount ||
               col < 0 || col >= colCount ||
               grid[row][col] != targetChar {
                return false
            }
            
            // If already visited → cycle found
            if visited[row][col] {
                return true
            }
            
            // Mark current cell as visited
            visited[row][col] = true
            
            // Explore all 4 directions
            for (dRow, dCol) in directions {
                let nextRow = row + dRow
                let nextCol = col + dCol
                
                // Skip the parent cell to prevent false cycle detection
                if nextRow == parentRow && nextCol == parentCol {
                    continue
                }
                
                // Continue DFS
                if dfs(nextRow, nextCol, row, col, targetChar) {
                    return true
                }
            }
            
            return false
        }
        
        // Start DFS from every unvisited cell
        for row in 0..<rowCount {
            for col in 0..<colCount {
                if !visited[row][col] {
                    if dfs(row, col, -1, -1, grid[row][col]) {
                        return true
                    }
                }
            }
        }
        
        return false
    }
}