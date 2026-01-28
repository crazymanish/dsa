final class Solution {

    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   Let:
    ///     - rows = number of rows
    ///     - cols = number of columns
    ///     - k    = teleport limit
    ///
    ///   • Sorting teleport cells:     O(rows * cols * log(rows * cols))
    ///   • DP relaxations (k + 1 times):
    ///       - Normal moves:           O(rows * cols)
    ///       - Teleport moves:         O(rows * cols)
    ///
    ///   Total:
    ///     O(rows * cols * log(rows * cols) + k * rows * cols)
    ///
    /// Space Complexity:
    ///   • O(rows * cols)
    ///     - DP grid
    ///     - Teleport metadata
    ///
    /// Problem Summary:
    ///   You move from (0,0) to (rows-1, cols-1).
    ///   - Normal moves: right or down, cost = grid cell value
    ///   - Teleport moves: between cells with the same value, cost = 0
    ///   - At most k teleports allowed
    ///
    /// Strategy:
    ///   Repeatedly relax the DP grid:
    ///     1) Normal grid movement
    ///     2) Teleport relaxation (grouped by value)
    /// -----------------------------------------------------------------------

    private let INF = Int.max / 4

    func minCost(_ grid: [[Int]], _ k: Int) -> Int {
        let rows = grid.count
        let cols = grid[0].count

        // dp[r][c] = minimum cost to reach (r, c)
        var dp = Array(
            repeating: Array(repeating: INF, count: cols),
            count: rows
        )
        dp[0][0] = 0

        // Collect all cells for teleport processing: (value, row, col)
        var teleportCells: [(value: Int, row: Int, col: Int)] = []
        teleportCells.reserveCapacity(rows * cols)

        for r in 0..<rows {
            for c in 0..<cols {
                teleportCells.append((grid[r][c], r, c))
            }
        }

        // Sort by value so equal-value cells are contiguous
        teleportCells.sort {
            if $0.value != $1.value { return $0.value < $1.value }
            if $0.row != $1.row { return $0.row < $1.row }
            return $0.col < $1.col
        }

        // Repeat relaxations up to k times
        for remainingTeleports in stride(from: k, through: 0, by: -1) {

            // 1️⃣ Normal DP relaxation (right & down)
            for r in 0..<rows {
                for c in 0..<cols {
                    let cost = grid[r][c]

                    if r > 0 {
                        dp[r][c] = min(dp[r][c], dp[r - 1][c] + cost)
                    }
                    if c > 0 {
                        dp[r][c] = min(dp[r][c], dp[r][c - 1] + cost)
                    }
                }
            }

            // 2️⃣ Teleport relaxation (if allowed)
            if remainingTeleports > 0 {
                relaxTeleports(dp: &dp, teleportCells: teleportCells)
            }
        }

        return dp[rows - 1][cols - 1]
    }

    /// -----------------------------------------------------------------------
    /// Teleport relaxation:
    ///   For each group of cells with the same value,
    ///   propagate the minimum dp value across the group.
    ///
    /// This allows teleporting between equal-value cells at zero cost.
    /// -----------------------------------------------------------------------
    private func relaxTeleports(
        dp: inout [[Int]],
        teleportCells: [(value: Int, row: Int, col: Int)]
    ) {
        let n = teleportCells.count

        var currentValue = -1
        var groupMin = INF

        // Forward pass: prefix minimum within each value group
        for i in 0..<n {
            let (value, r, c) = teleportCells[i]

            if value != currentValue {
                currentValue = value
                groupMin = dp[r][c]
            } else {
                groupMin = min(groupMin, dp[r][c])
                dp[r][c] = groupMin
            }
        }

        // Backward pass: suffix minimum within each group
        var suffixMin = dp[
            teleportCells[n - 1].row
        ][
            teleportCells[n - 1].col
        ]

        for i in stride(from: n - 2, through: 0, by: -1) {
            let (_, r, c) = teleportCells[i]
            if dp[r][c] < suffixMin {
                suffixMin = dp[r][c]
            } else {
                dp[r][c] = suffixMin
            }
        }
    }
}
