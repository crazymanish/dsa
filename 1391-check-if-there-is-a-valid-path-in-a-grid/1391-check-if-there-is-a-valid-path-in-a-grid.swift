class Solution {
    /**
     Problem Summary:
     Determine if there exists a valid path from the top-left corner to the
     bottom-right corner in a grid of street tiles. Each tile allows movement
     only in specific directions, and movement between adjacent cells is valid
     only if both tiles connect to each other.
     
     Strategy:
     - Use Depth-First Search (DFS) starting from (0,0).
     - At each cell, explore all allowed directions based on its street type.
     - Move to a neighbor only if:
       1. It is within bounds.
       2. It has not been visited.
       3. The neighbor has a direction that connects back (bidirectional check).
     - If we reach the bottom-right cell, return true.
     
     Time Complexity:
     O(m * n) — each cell is visited once.
     
     Space Complexity:
     O(m * n) — recursion stack + visited set.
     */
    func hasValidPath(_ grid: [[Int]]) -> Bool {
        let rowCount = grid.count
        let colCount = grid[0].count
        
        // Mapping each street type to the directions it supports
        let streetToDirections: [Int: [Direction]] = [
            1: [.left, .right],
            2: [.up, .down],
            3: [.left, .down],
            4: [.right, .down],
            5: [.left, .up],
            6: [.right, .up]
        ]
        
        // Track visited cells using flattened index
        var visitedCells = Set<Int>()
        
        // DFS helper function to explore paths recursively
        func dfs(_ row: Int, _ col: Int) -> Bool {
            
            // If destination is reached, path is valid
            if row == rowCount - 1 && col == colCount - 1 {
                return true
            }
            
            // Mark current cell as visited
            visitedCells.insert(row * colCount + col)
            
            // Explore all valid directions from current cell
            for direction in streetToDirections[grid[row][col], default: []] {
                let (deltaRow, deltaCol) = direction.delta
                let nextRow = row + deltaRow
                let nextCol = col + deltaCol
                let nextIndex = nextRow * colCount + nextCol
                
                // Check bounds and ensure the cell is not visited
                guard nextRow >= 0, nextCol >= 0,
                      nextRow < rowCount, nextCol < colCount,
                      !visitedCells.contains(nextIndex) else {
                    continue
                }
                
                // Ensure the neighbor connects back to current cell
                if let neighborDirections = streetToDirections[grid[nextRow][nextCol]],
                   neighborDirections.contains(direction.opposite) {
                    
                    // Recursively explore the neighbor
                    if dfs(nextRow, nextCol) {
                        return true
                    }
                }
            }
            
            // No valid path found from this cell
            return false
        }
        
        return dfs(0, 0)
    }
}

enum Direction {
    case left, right, up, down
    
    /// Movement delta for each direction
    var delta: (Int, Int) {
        switch self {
        case .left: return (0, -1)
        case .right: return (0, 1)
        case .up: return (-1, 0)
        case .down: return (1, 0)
        }
    }
    
    /// Opposite direction (used to validate bidirectional connection)
    var opposite: Direction {
        switch self {
        case .left: return .right
        case .right: return .left
        case .up: return .down
        case .down: return .up
        }
    }
}