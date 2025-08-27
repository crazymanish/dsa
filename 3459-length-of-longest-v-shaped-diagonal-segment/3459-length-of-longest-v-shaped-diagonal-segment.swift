// Time Complexity: O(R * C)
//   - R: The number of rows in the grid.
//   - C: The number of columns in the grid.
//   - The solution uses a memoized DFS. The number of unique states for our cache is determined by
//     (row, col, direction, hasTurned, prevValue). This gives R * C * 4 * 2 * 3 = 24 * R * C states.
//   - Since each state is computed only once, and the work per state is constant, the overall
//     time complexity is proportional to the number of states, which is O(R * C).
//
// Space Complexity: O(R * C)
//   - The `cache` dictionary stores the results for each state, leading to O(R * C) space.
//   - The recursion depth can also contribute O(R * C) to the call stack in the worst case.
class Solution {

    // Using an enum for directions improves readability over integer indices.
    private enum Direction: Int {
        case topLeft, topRight, bottomLeft, bottomRight
    }
    
    // A custom struct for the memoization cache key. This is more performant
    // and type-safe than using an interpolated string.
    private struct State: Hashable {
        let row: Int
        let col: Int
        let direction: Direction
        let hasTurned: Bool
        let prevValue: Int
    }
    
    // Using a dictionary to map directions to their coordinate deltas (dr, dc).
    private let deltas: [Direction: (dr: Int, dc: Int)] = [
        .topLeft: (-1, -1), .topRight: (-1, 1),
        .bottomLeft: (1, -1), .bottomRight: (1, 1)
    ]
    
    // This dictionary defines the specific, hardcoded turn logic for this solution.
    private let turnMap: [Direction: Direction] = [
        .topLeft: .topRight, .topRight: .bottomRight,
        .bottomLeft: .topLeft, .bottomRight: .bottomLeft
    ]

    private var cache: [State: Int] = [:]
    
    /**
     * Finds the length of the longest "V-shaped" diagonal path.
     */
    func lenOfVDiagonal(_ grid: [[Int]]) -> Int {
        guard !grid.isEmpty, !grid[0].isEmpty else { return 0 }
        
        var maxLength = 0
        cache = [:] // Reset cache for each run.

        for i in 0..<grid.count {
            for j in 0..<grid[i].count {
                // The problem is defined to start paths from cells with value 1.
                if grid[i][j] == 1 {
                    // Try starting a path in all 4 diagonal directions from this cell.
                    let path1 = 1 + findMaxPathLength(grid, i - 1, j - 1, .topLeft, false, 1)
                    let path2 = 1 + findMaxPathLength(grid, i - 1, j + 1, .topRight, false, 1)
                    let path3 = 1 + findMaxPathLength(grid, i + 1, j - 1, .bottomLeft, false, 1)
                    let path4 = 1 + findMaxPathLength(grid, i + 1, j + 1, .bottomRight, false, 1)
                    
                    maxLength = max(maxLength, path1, path2, path3, path4)
                }
            }
        }
        return maxLength
    }

    /**
     * A recursive DFS helper to find the max path length from a given state.
     */
    private func findMaxPathLength(_ grid: [[Int]], _ row: Int, _ col: Int, _ direction: Direction, _ hasTurned: Bool, _ prevValue: Int) -> Int {
        // Base Case 1: Out of bounds.
        if row < 0 || row >= grid.count || col < 0 || col >= grid[0].count {
            return 0
        }
        
        // Base Case 2: Value alternation rule is violated.
        // This solution implements a specific 1 -> 2 -> 0 -> 2... pattern.
        let currentValue = grid[row][col]
        if (prevValue == 0 || prevValue == 1) && currentValue != 2 { return 0 }
        if prevValue == 2 && currentValue != 0 { return 0 }

        // Check cache for a pre-computed result for the current state.
        let state = State(row: row, col: col, direction: direction, hasTurned: hasTurned, prevValue: prevValue)
        if let cachedValue = cache[state] {
            return cachedValue
        }

        // --- Recursive Step (Refactored to remove repetition) ---
        let (dr, dc) = deltas[direction]!
        
        // Path 1: Continue straight without turning.
        let pathWithoutTurn = 1 + findMaxPathLength(grid, row + dr, col + dc, direction, hasTurned, currentValue)
        
        var maxLength = pathWithoutTurn
        
        // Path 2: If a turn is allowed, explore the turning path.
        if !hasTurned {
            let turnedDirection = turnMap[direction]!
            let (turnedDr, turnedDc) = deltas[turnedDirection]!
            
            let pathWithTurn = 1 + findMaxPathLength(grid, row + turnedDr, col + turnedDc, turnedDirection, true, currentValue)
            maxLength = max(maxLength, pathWithTurn)
        }
        
        // Cache the result for the current state before returning.
        cache[state] = maxLength
        return maxLength
    }
}