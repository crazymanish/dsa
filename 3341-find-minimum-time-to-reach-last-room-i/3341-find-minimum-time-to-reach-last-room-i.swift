class Solution {
    /**
     * Performs a Depth First Search to find the minimum time to reach each cell.
     *
     * - Parameters:
     * - currentRow: The current row index.
     * - currentCol: The current column index.
     * - arrivalTimeAtPrevCell: The time of arrival at the cell from which we moved to the current cell.
     * For the starting cell (0,0), this is the initial start time (e.g., 0).
     * - cellReadyTimeGrid: A 2D array where `cellReadyTimeGrid[r][c]` is a time constraint for cell (r,c).
     * The step involving cell (r,c) cannot effectively start before `cellReadyTimeGrid[r][c]`.
     * - minArrivalTimeGrid: A 2D array (passed by reference) to store the minimum arrival time found so far for each cell.
     * Updated by the DFS.
     *
     * - Time Complexity (DFS part):
     * In the worst case, this can be complex to analyze precisely without knowing constraints on `moveTime` values.
     * It's similar to the Bellman-Ford or SPFA algorithm if we consider updates.
     * If R is rows, C is columns:
     * - Number of states (cells): R * C.
     * - Each cell's `minArrivalTimeGrid` value can be updated multiple times if longer paths are explored first
     * that later get superseded by shorter paths found via other branches of the DFS.
     * - A loose upper bound might be O((R*C)^2) for SPFA-like behavior in dense graphs,
     * but for grids, it often performs better, closer to O(R*C * Factor), where Factor depends on value ranges.
     * - If all effective edge weights were 1 (e.g., `moveTime` is always 0), it would be O(R*C) due to pruning.
     *
     * - Space Complexity (DFS part):
     * - O(R * C) for the recursion stack in the worst case (e.g., a snake-like path through the grid).
     */
    private func findMinTimesDFS(
        _ currentRow: Int,
        _ currentCol: Int,
        _ arrivalTimeAtPrevCell: Int, // This is the `minArrivalTimeGrid` value of the cell we are coming FROM
        _ cellReadyTimeGrid: [[Int]],
        _ minArrivalTimeGrid: inout [[Int]] // Stores the earliest arrival time at (row, col)
    ) {
        // Boundary checks for the current cell
        guard currentRow >= 0 && currentRow < cellReadyTimeGrid.count &&
              currentCol >= 0 && currentCol < cellReadyTimeGrid[0].count else {
            return // Out of bounds
        }

        // Calculate the arrival time at the current cell (currentRow, currentCol)
        let calculatedArrivalTimeAtCurrentCell: Int
        if currentRow == 0 && currentCol == 0 {
            // For the starting cell (0,0), the arrival time is the initial `arrivalTimeAtPrevCell`
            // passed to the first call (typically 0).
            calculatedArrivalTimeAtCurrentCell = arrivalTimeAtPrevCell
        } else {
            // For other cells:
            // To arrive at (currentRow, currentCol) from `PrevCell`:
            // 1. We must have arrived at `PrevCell` (at `arrivalTimeAtPrevCell`).
            // 2. The current cell (currentRow, currentCol) itself has a "ready time" (`cellReadyTimeGrid[currentRow][currentCol]`).
            //    This means any activity/transition involving the current cell cannot effectively start before this time.
            // 3. The time when both conditions are met (ready to leave `PrevCell` AND current cell is ready for this step)
            //    is `max(arrivalTimeAtPrevCell, cellReadyTimeGrid[currentRow][currentCol])`.
            // 4. Then, add 1 unit of time for the actual move/processing from `PrevCell` to the current cell.
            let effectiveDepartureTimeFromPrev = max(arrivalTimeAtPrevCell, cellReadyTimeGrid[currentRow][currentCol])
            calculatedArrivalTimeAtCurrentCell = effectiveDepartureTimeFromPrev + 1
        }

        // If we've already found a path to the current cell that's shorter or equal, prune this path.
        guard calculatedArrivalTimeAtCurrentCell < minArrivalTimeGrid[currentRow][currentCol] else {
            return
        }

        // Update the minimum arrival time for the current cell
        minArrivalTimeGrid[currentRow][currentCol] = calculatedArrivalTimeAtCurrentCell

        // Explore neighbors: up, down, left, right
        // The `calculatedArrivalTimeAtCurrentCell` becomes the `arrivalTimeAtPrevCell` for the next DFS call.
        findMinTimesDFS(currentRow + 1, currentCol, calculatedArrivalTimeAtCurrentCell, cellReadyTimeGrid, &minArrivalTimeGrid) // Down
        findMinTimesDFS(currentRow - 1, currentCol, calculatedArrivalTimeAtCurrentCell, cellReadyTimeGrid, &minArrivalTimeGrid) // Up
        findMinTimesDFS(currentRow, currentCol + 1, calculatedArrivalTimeAtCurrentCell, cellReadyTimeGrid, &minArrivalTimeGrid) // Right
        findMinTimesDFS(currentRow, currentCol - 1, calculatedArrivalTimeAtCurrentCell, cellReadyTimeGrid, &minArrivalTimeGrid) // Left
    }

    /**
     * Calculates the minimum time to reach the bottom-right corner of a grid.
     *
     * - Parameter cellReadyTimeGrid: A 2D array where `cellReadyTimeGrid[r][c]` is a time constraint
     * that must be met before the step involving cell (r,c) can effectively occur.
     * Movement from one cell to an adjacent one takes 1 unit of time.
     * - Returns: The minimum time to arrive at the bottom-right cell, or Int.max if unreachable (though
     * with this problem structure, if connected, it should be reachable).
     *
     * - Overall Time Complexity: Dominated by the DFS. See `findMinTimesDFS`.
     * - Overall Space Complexity: O(R * C) for `minArrivalTimeGrid` and DFS stack.
     */
    func minTimeToReach(_ cellReadyTimeGrid: [[Int]]) -> Int {
        // Grid dimensions
        guard let numRows = cellReadyTimeGrid.first?.count, numRows > 0 else {
            // Or handle empty grid / first row empty as an error or specific value
            return cellReadyTimeGrid.isEmpty ? 0 : -1 // Example: return -1 for invalid input
        }
        let numCols = cellReadyTimeGrid[0].count

        // `minArrivalTimeGrid[r][c]` will store the minimum time to arrive at cell (r,c).
        // Initialize with a large value (infinity).
        var minArrivalTimeGrid = Array(repeating: Array(repeating: Int.max, count: numCols), count: cellReadyTimeGrid.count)

        // Start DFS from cell (0,0). The initial "arrival time at previous cell" is 0,
        // representing the start time before entering (0,0).
        findMinTimesDFS(0, 0, 0, cellReadyTimeGrid, &minArrivalTimeGrid)

        // The result is the minimum arrival time at the bottom-right cell.
        // If `minArrivalTimeGrid.last!.last!` is still `Int.max`, it means the cell was unreachable.
        return minArrivalTimeGrid[cellReadyTimeGrid.count - 1][numCols - 1]
    }
}
/*
```

**Explanation of the Logic:**

1.  **`minArrivalTimeGrid[r][c]`**: This 2D array stores the earliest time you can *arrive* at cell `(r, c)`. It's initialized to `Int.max`.
2.  **`cellReadyTimeGrid[r][c]`**: This is the input grid. The value in this grid for a cell `(r,c)` acts as a "gate opening time" or a "readiness constraint" for that cell. Any step or transition that effectively involves cell `(r,c)` cannot begin before `cellReadyTimeGrid[r][c]`.
3.  **`arrivalTimeAtPrevCell` (DFS parameter)**: When `findMinTimesDFS` is called for a `currentCell`, this parameter holds the arrival time at the `previousCell` from which we are moving.
4.  **Calculating `calculatedArrivalTimeAtCurrentCell`**:
    * **For the starting cell (0,0)**: The arrival time is simply the initial `arrivalTimeAtPrevCell` passed to the first DFS call (which is `0` in `minTimeToReach`). So, `minArrivalTimeGrid[0][0]` becomes `0`.
    * **For any other cell `C = (currentRow, currentCol)` reached from `P = previousCell`**:
        * You arrived at `P` at `arrivalTimeAtPrevCell`.
        * The current cell `C` has its own readiness constraint: `cellReadyTimeGrid[currentRow][currentCol]`.
        * The effective time when you can start "processing" the step from `P` to `C` (considering `C`'s constraint) is `max(arrivalTimeAtPrevCell, cellReadyTimeGrid[currentRow][currentCol])`. Let this be `T_effective_departure_from_P`.
        * The actual move/travel from `P` to `C` takes `1` unit of time.
        * So, the arrival time at `C` is `T_effective_departure_from_P + 1`.
5.  **Pruning**: If the `calculatedArrivalTimeAtCurrentCell` is not better (i.e., less) than the already recorded `minArrivalTimeGrid[currentRow][currentCol]`, this path is pruned because we've found a faster or equally fast way to reach this cell.
6.  **Recursion**: If a better time is found, `minArrivalTimeGrid` is updated, and the DFS proceeds to all valid neighbors. The `calculatedArrivalTimeAtCurrentCell` for the current cell becomes the `arrivalTimeAtPrevCell` for the recursive calls to its neighbors.
7.  **Result**: The final answer is the value in `minArrivalTimeGrid` for the bottom-right cell.

This logic correctly models a scenario where each step takes 1 unit of time, but progressing to the *next* cell `C` depends on both your arrival time at the *previous* cell `P` and a readiness condition (`cellReadyTimeGrid[C]`) of cell `C` itse

*/