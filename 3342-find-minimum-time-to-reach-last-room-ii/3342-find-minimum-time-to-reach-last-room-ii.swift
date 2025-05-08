import Collections // Assuming this is for the Swift Collections Heap

// Represents a state in the Dijkstra's algorithm search.
struct PathState: Comparable, CustomStringConvertible {
    let row: Int // Current row
    let col: Int // Current column
    let timeAtCell: Int // Time of arrival at (row, col)
    let costForNextMove: Int // Cost to move *from* this (row, col) to an adjacent cell

    var description: String {
        "PathState(row: \(row), col: \(col), timeAtCell: \(timeAtCell), costForNextMove: \(costForNextMove))"
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        // Equality is based on all properties for completeness, though for Dijkstra,
        // primarily row, col, and timeAtCell (and potentially costForNextMove if it defines unique states) matter.
        return lhs.row == rhs.row &&
               lhs.col == rhs.col &&
               lhs.timeAtCell == rhs.timeAtCell &&
               lhs.costForNextMove == rhs.costForNextMove
    }

    static func < (lhs: Self, rhs: Self) -> Bool {
        // Primary sort key: timeAtCell (earliest arrival time first).
        if lhs.timeAtCell != rhs.timeAtCell {
            return lhs.timeAtCell < rhs.timeAtCell
        }
        // Secondary sort key: costForNextMove (if times are equal, prefer path with cheaper next step).
        // This can help explore promising paths slightly earlier, though not strictly necessary for correctness
        // if timeAtCell is the only true measure of "distance" for visited tracking.
        if lhs.costForNextMove != rhs.costForNextMove {
            return lhs.costForNextMove < rhs.costForNextMove
        }
        // Tertiary sort key: row, then column (for deterministic behavior if all else is equal).
        if lhs.row != rhs.row {
            return lhs.row < rhs.row
        }
        return lhs.col < rhs.col
    }
}

class Solution {
    /**
     * Calculates the minimum time to reach the bottom-right corner of a grid.
     *
     * - Parameters:
     * - cellReadyTimes: A 2D array where `cellReadyTimes[r][c]` is the earliest time
     * the cell (r,c) can be "processed" or "entered effectively".
     * Movement from one cell to an adjacent one has an alternating cost (1 then 2, or 2 then 1).
     *
     * - Returns: The minimum time to reach the bottom-right cell, or -1 if unreachable.
     *
     * - Time Complexity: O(R * C * log(R * C)), where R is the number of rows and C is the number of columns.
     * - The number of states pushed onto the heap can be at most R * C (each cell).
     * While a cell might be reached with different `costForNextMove`, the `minTimesToReachCell`
     * array helps prune paths that are definitively worse for reaching a cell.
     * - Each heap operation (insert, popMin) takes O(log N_heap), where N_heap is the number of elements in the heap.
     * N_heap can be up to R * C.
     * - We iterate up to 4 neighbors for each popped state.
     *
     * - Space Complexity: O(R * C).
     * - `minHeap`: In the worst case, can store a significant portion of the grid cells: O(R * C).
     * - `minTimesToReachCell`: Stores the minimum time for each cell: O(R * C).
     */
    func minTimeToReach(_ cellReadyTimes: [[Int]]) -> Int {
        guard !cellReadyTimes.isEmpty, !cellReadyTimes[0].isEmpty else {
            return -1 // Or handle as per problem specification for empty/invalid grid
        }

        let numRows = cellReadyTimes.count
        let numCols = cellReadyTimes[0].count

        // Min-heap to prioritize paths with the smallest `timeAtCell`.
        var minHeap = Heap<PathState>()

        // `minTimesToReachCell[r][c]` stores the minimum time found so far to arrive at cell (r,c).
        // Initialized to Int.max, representing infinity.
        var minTimesToReachCell = Array(repeating: Array(repeating: Int.max, count: numCols), count: numRows)

        // Initial state: Start at (0,0) at time 0.
        // The first move from (0,0) will cost 1.
        let initialTimeAtStartCell = 0 // Arrive at (0,0) at time 0.
        
        // The problem implies we need to consider cellReadyTimes[0][0] for the very first step.
        // If the problem means time 0 is *before* considering cellReadyTimes[0][0]:
        let effectiveStartTime = max(0, cellReadyTimes[0][0])
        // However, the provided code's `currPath.timePassed >= moveTime[newRow][newCol]` logic suggests
        // `timePassed` is the arrival at `currPath.r, currPath.c` and `moveTime[newRow][newCol]` is for the *next* cell.
        // So, for the start, let's assume `timeAtCell = 0` for (0,0) is the arrival time, and `cellReadyTimes[0][0]`
        // would apply if we were "moving to" (0,0) from a conceptual previous point.
        // Let's stick to `timeAtCell = 0` for (0,0) and the logic will handle `cellReadyTimes` for subsequent moves.
        
        minHeap.insert(PathState(row: 0, col: 0, timeAtCell: initialTimeAtStartCell, costForNextMove: 1))
        minTimesToReachCell[0][0] = initialTimeAtStartCell


        // Possible moves: up, down, left, right
        let rowOffsets = [-1, 1, 0, 0]
        let colOffsets = [0, 0, -1, 1]

        while let currentPath = minHeap.popMin() {
            // If this path is already suboptimal (a shorter path to this cell was found earlier), skip.
            // This check is important if we can add multiple paths to the same cell to the heap
            // before the absolute shortest is processed.
            if currentPath.timeAtCell > minTimesToReachCell[currentPath.row][currentPath.col] {
                continue
            }

            // Goal check: If we reached the bottom-right cell.
            if currentPath.row == numRows - 1 && currentPath.col == numCols - 1 {
                return currentPath.timeAtCell
            }

            // Explore neighbors.
            for i in 0..<4 {
                let newRow = currentPath.row + rowOffsets[i]
                let newCol = currentPath.col + colOffsets[i]

                // Boundary check for the new cell.
                guard (0..<numRows).contains(newRow) && (0..<numCols).contains(newCol) else {
                    continue
                }

                // Calculate arrival time at the new cell:
                // 1. Determine the earliest we can "start" the move from currentPath.timeAtCell,
                //    considering the new cell's ready time.
                //    The `currentPath.timeAtCell` is the arrival time at `(currentPath.row, currentPath.col)`.
                //    The `cellReadyTimes[newRow][newCol]` is the ready time for the target cell.
                //    We can only effectively "use" the new cell from `max(currentPath.timeAtCell, cellReadyTimes[newRow][newCol])`.
                let effectiveDepartureTime = max(currentPath.timeAtCell, cellReadyTimes[newRow][newCol])
                
                // 2. Add the cost of the current move.
                let arrivalTimeAtNewCell = effectiveDepartureTime + currentPath.costForNextMove

                // If this path to `(newRow, newCol)` is better than previously found paths.
                if arrivalTimeAtNewCell < minTimesToReachCell[newRow][newCol] {
                    minTimesToReachCell[newRow][newCol] = arrivalTimeAtNewCell
                    
                    // Determine the cost for the move *from* the new cell.
                    let costForMoveFromNewCell = (currentPath.costForNextMove == 1) ? 2 : 1
                    
                    let newPath = PathState(row: newRow,
                                          col: newCol,
                                          timeAtCell: arrivalTimeAtNewCell,
                                          costForNextMove: costForMoveFromNewCell)
                    minHeap.insert(newPath)
                }
            }
        }

        // If the loop finishes and the target was not reached.
        return -1
    }
}
