// --- Complexity Analysis ---
//
// Let R = numRows (m), C = numCols (n)
// Let G = number of guards, W = number of walls
//
// Time Complexity: O(R*C + W + G*(R+C))
//
// 1. Grid Initialization: `O(R * C)`
//    We create an R x C grid, initializing every cell.
//
// 2. Marking Walls: `O(W)`
//    We iterate through all W walls and perform an O(1) grid update for each.
//
// 3. Marking Guards: `O(G)`
//    We iterate through all G guards and perform an O(1) grid update for each.
//
// 4. Marking Guarded Cells: `O(G * (R + C))`
//    - We loop `G` times (once for each guard).
//    - For each guard, we "shine a light" in 4 directions.
//    - The maximum distance in a direction is R (up/down) or C (left/right).
//    - The total work per guard is `O(R + C)`.
//    - Total time for this step is `O(G * (R + C))`.
//
// 5. Counting Unguarded: `O(R * C)`
//    We iterate through the entire R x C grid one last time to count.
//
// Total Time: `O(R*C + W + G + G*(R+C) + R*C)`
// Since `W + G` is at most `R * C`, the formula simplifies to:
// `O(R*C + G*(R+C))`
//
// Space Complexity: O(R * C)
//
// 1. Grid: `O(R * C)`
//    We must store the state for every cell in the grid.
// 2. Directions: `O(1)`
//    This is a constant-size array.
// 3. The recursion stack for the helper is not a factor as it's an
//    iterative `while` loop, using `O(1)` space.

class Solution {
    
    // Enum to represent the state of each cell in the grid.
    // Using an enum makes the code much more readable than using integers (0, 1, 2, 3).
    enum CellState {
        case empty      // Unguarded, empty cell
        case wall       // A wall (obstacle)
        case `guard`      // A guard (obstacle and source of light)
        case guarded    // An empty cell that is seen by a guard
    }
    
    /// Counts the number of "empty" cells that are not "guarded" by any guard.
    func countUnguarded(_ numRows: Int, _ numCols: Int, _ guards: [[Int]], _ walls: [[Int]]) -> Int {
        
        // 1. Create a grid to track cell states
        var grid = Array(repeating: Array(repeating: CellState.empty, count: numCols), count: numRows)
        
        // 2. Mark initial obstacles (walls and guards) on the grid
        for wallPos in walls {
            grid[wallPos[0]][wallPos[1]] = .wall
        }
        
        // Mark guards on the grid *after* walls.
        for guardPos in guards {
            grid[guardPos[0]][guardPos[1]] = .guard
        }
        
        // Directions: up, right, down, left
        let directions = [
            (-1, 0),  // Up
            (0, 1),   // Right
            (1, 0),   // Down
            (0, -1)   // Left
        ]
        
        // 3. Mark all cells "seen" by guards
        // For each guard, simulate its line of sight in all 4 directions.
        for guardPos in guards {
            for (dr, dc) in directions {
                // Call helper function to mark cells in one direction
                markGuardedCells(grid: &grid, row: guardPos[0], col: guardPos[1], dr: dr, dc: dc)
            }
        }
        
        // 4. Count remaining unguarded (empty) cells
        var unguardedCount = 0
        for r in 0..<numRows {
            for c in 0..<numCols {
                // Any cell still in the "empty" state has not been
                // seen by a guard and is not an obstacle.
                if grid[r][c] == .empty {
                    unguardedCount += 1
                }
            }
        }
        
        return unguardedCount
    }
    
    /// Helper function to mark guarded cells starting from a guard's position
    /// and moving in a specific direction (dr, dc).
    func markGuardedCells(grid: inout [[CellState]], row: Int, col: Int, dr: Int, dc: Int) {
        
        // Start from the cell *adjacent* to the guard
        var currentRow = row + dr
        var currentCol = col + dc
        
        // Get grid boundaries
        let numRows = grid.count
        let numCols = grid[0].count
        
        // Continue "shining the light" until we go off-grid or hit an obstacle
        while currentRow >= 0 && currentRow < numRows &&
              currentCol >= 0 && currentCol < numCols {
            
            let cellState = grid[currentRow][currentCol]
            
            // Stop if we hit a wall or another guard
            if cellState == .wall || cellState == .guard {
                break
            }
            
            // Mark the cell as guarded if it's currently empty
            // If it's already .guarded (by another guard), we leave it as .guarded
            if cellState == .empty {
                grid[currentRow][currentCol] = .guarded
            }
            
            // Move to the next cell in the direction
            currentRow += dr
            currentCol += dc
        }
    }
}