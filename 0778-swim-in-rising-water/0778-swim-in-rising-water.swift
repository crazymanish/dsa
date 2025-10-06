// Time Complexity: O(N² log N)
// The algorithm uses binary search on the answer (time `t`). The range of time is
// from 0 up to N*N. This results in O(log(N²)) = O(log N) iterations for the
// binary search. For each candidate time `t`, we perform a DFS to check for a
// valid path, which takes O(N²) time as it may visit every cell. The total
// time complexity is therefore O(N² * log N).
//
// Space Complexity: O(N²)
// The space is dominated by the DFS traversal. The recursion call stack depth and
// the `visited` set can both grow to the size of the grid, O(N²), in the worst case.
class Solution {
    // Pre-defined directions for exploring neighbors in the DFS.
    let dirs = [(-1, 0), (1, 0), (0, 1), (0, -1)]

    func swimInWater(_ grid: [[Int]]) -> Int {
        guard !grid.isEmpty else { return 0 }
        
        let n = grid.count
        
        // The search space for time `t`:
        // `left`: The minimum possible time is the height of the starting cell itself.
        // `right`: A safe upper bound is n*n, the max possible elevation value.
        var left = grid[0][0]
        var right = n * n
        var result = -1

        // Perform binary search to find the minimum valid time `t`.
        while left <= right {
            // `mid` is our candidate time `t`.
            let mid = left + (right - left) / 2

            // Check if a path from start to finish exists at this time `mid`.
            if possible(grid, mid) {
                // If a path exists, `mid` is a valid answer. We store it and try for an
                // even smaller time to find the absolute minimum.
                result = mid 
                right = mid - 1 
            } else {
                // If no path exists, the time `mid` is too low. We need a higher water level.
                left = mid + 1
            }
        }
        return result
    }

    // This function and its helper check if a path from (0,0) to (n-1, n-1) exists
    // given a maximum water level `time`.
    private func possible(_ grid: [[Int]], _ time: Int) -> Bool {
        // A path is impossible if the starting cell itself is higher than the water level.
        guard grid[0][0] <= time else { return false }
        
        var visited = Set<String>()
        return possibleHelper(grid, 0, 0, &visited, time)
    }

    // The recursive DFS helper to find a valid path.
    private func possibleHelper(_ grid: [[Int]], _ row: Int, _ col: Int, _ visited: inout Set<String>, _ time: Int) -> Bool {
        // Base case: We've successfully reached the destination.
        if row == grid.count - 1 && col == grid.count - 1 { return true }
        
        visited.insert("\(row)-\(col)")

        for (r, c) in dirs {
            let newRow = row + r
            let newCol = col + c
            
            // Check 1: Stay within the grid bounds.
            guard newRow >= 0 && newRow < grid.count && newCol >= 0 && newCol < grid[0].count else { continue }
            // Check 2: Don't revisit cells.
            guard !visited.contains("\(newRow)-\(newCol)") else { continue }
            // Check 3: We can only swim to a neighbor if its elevation is at most `time`.
            guard grid[newRow][newCol] <= time else { continue }
            
            // If a path is found from this neighbor, propagate `true` up the call stack.
            if possibleHelper(grid, newRow, newCol, &visited, time) {
                return true
            }
        }
        // No path was found from the current cell.
        return false
    }
}