class Solution {
    /*
     Problem Summary:
     Determine whether there exists a path from the top-left cell to the
     bottom-right cell while maintaining at least 1 health. Entering an
     unsafe cell (value = 1) decreases health by 1.

     Strategy:
     - Use DFS to explore all possible paths.
     - Memoize each state (remainingHealth, row, col) to avoid
       recomputing previously explored states.
     - Track visited cells in the current path to prevent cycles.

     Time Complexity:
     O(rows × cols × health)

     Space Complexity:
     O(rows × cols × health)
     */

    private var memo: [[Int]: Bool] = [:]

    private let directions = [
        (0, 1), (0, -1),
        (1, 0), (-1, 0)
    ]

    func findSafeWalk(_ grid: [[Int]], _ health: Int) -> Bool {
        let rowCount = grid.count
        let columnCount = grid[0].count

        let visited = Array(
            repeating: Array(repeating: false, count: columnCount),
            count: rowCount
        )

        return canReachDestination(grid, health, 0, 0, visited, rowCount, columnCount)
    }

    private func canReachDestination(_ grid: [[Int]], _ health: Int, _ row: Int, _ column: Int, _ visited: [[Bool]], _ rowCount: Int, _ columnCount: Int) -> Bool {

        // Reject invalid positions or already visited cells.
        guard row >= 0,
              row < rowCount,
              column >= 0,
              column < columnCount,
              health > 0,
              !visited[row][column] else {
            return false
        }

        // Lose one health if the current cell is unsafe.
        let remainingHealth = health - grid[row][column]

        // Health must remain at least 1 after entering this cell.
        guard remainingHealth > 0 else {
            return false
        }

        let state = [remainingHealth, row, column]

        // Return the cached result if this state was already explored.
        if let cachedResult = memo[state] {
            return cachedResult
        }

        // Successfully reached the destination.
        if row == rowCount - 1 && column == columnCount - 1 {
            memo[state] = true
            return true
        }

        // Mark the current cell as visited for this DFS path.
        var nextVisited = visited
        nextVisited[row][column] = true

        // Explore all four possible directions.
        for (rowOffset, columnOffset) in directions {
            if canReachDestination(
                grid,
                remainingHealth,
                row + rowOffset,
                column + columnOffset,
                nextVisited,
                rowCount,
                columnCount
            ) {
                memo[state] = true
                return true
            }
        }

        // No valid path exists from this state.
        memo[state] = false
        return false
    }
}