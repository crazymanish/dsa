/// ---------------------------------------------------------------------------
/// Algorithm: 2D Difference Array (Optimized Range Increment)
///
/// Time Complexity:
///   • Applying updates:          O(queryCount)
///   • Computing prefix sums:     O(n²)
///   • Total complexity:          O(queryCount + n²)
///
/// Space Complexity:
///   • O(n²) for the differenceGrid + final output grid
///
/// Description:
///   Instead of incrementing each cell for every query, we update only
///   the corners of a 2D "difference grid". After all updates are applied,
///   we compute prefix sums to reconstruct the actual incremented grid.
/// ---------------------------------------------------------------------------

class Solution {
    func rangeAddQueries(_ n: Int, _ queries: [[Int]]) -> [[Int]] {
        // Difference grid (size n+1 to safely apply boundaries)
        var differenceGrid = Array(
            repeating: Array(repeating: 0, count: n + 1),
            count: n + 1
        )

        // Step 1: Apply difference updates for each query rectangle
        for query in queries {
            let topRow = query[0]
            let leftCol = query[1]
            let bottomRow = query[2]
            let rightCol = query[3]

            // Add +1 at the top-left corner
            differenceGrid[topRow][leftCol] += 1

            // Mark -1 just outside right boundary
            if rightCol + 1 < n {
                differenceGrid[topRow][rightCol + 1] -= 1
            }

            // Mark -1 just outside bottom boundary
            if bottomRow + 1 < n {
                differenceGrid[bottomRow + 1][leftCol] -= 1
            }

            // Fix the overlapping subtraction by adding +1 at bottom-right+1
            if bottomRow + 1 < n && rightCol + 1 < n {
                differenceGrid[bottomRow + 1][rightCol + 1] += 1
            }
        }

        // Step 2: Row-wise prefix sums
        for row in 0..<n {
            for col in 1..<n {
                differenceGrid[row][col] += differenceGrid[row][col - 1]
            }
        }

        // Step 3: Column-wise prefix sums
        for col in 0..<n {
            for row in 1..<n {
                differenceGrid[row][col] += differenceGrid[row - 1][col]
            }
        }

        // Step 4: Extract the final n×n result grid
        var resultGrid = Array(
            repeating: Array(repeating: 0, count: n),
            count: n
        )

        for row in 0..<n {
            for col in 0..<n {
                resultGrid[row][col] = differenceGrid[row][col]
            }
        }

        return resultGrid
    }
}
