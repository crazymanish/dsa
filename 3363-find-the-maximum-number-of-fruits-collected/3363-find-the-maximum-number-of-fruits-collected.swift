// Time Complexity: O(N^2)
//   - N: The side length of the square `fruits` grid.
//   - The main loop iterates `step` from 1 to N-2, which is O(N) iterations.
//   - Inside, the inner loop iterates `offset` up to `searchWindowSize`. The `searchWindowSize`
//     grows and shrinks but its maximum size is proportional to N.
//   - Therefore, the nested loops result in a time complexity of O(N * N) = O(N^2).
//
// Space Complexity: O(N)
//   - We use two DP arrays, `topRightPathDP` and `bottomLeftPathDP`.
//   - The size of these arrays is determined by `searchWindowSize`, which has a maximum size of O(N).
//   - Thus, the space required is O(N) to store the DP states for the current step.
class Solution {
    /**
     * Calculates the maximum number of fruits that can be collected from a grid.
     * This is achieved by simulating three collectors:
     * 1. A primary collector gathers all fruits on the main diagonal.
     * 2. A second collector starts at the top-right corner and moves towards the diagonal.
     * 3. A third collector starts at the bottom-left corner and moves towards the diagonal.
     * The function uses dynamic programming to find the optimal paths for collectors 2 and 3.
     *
     * - Parameter fruits: A 2D array (square grid) of integers representing fruit counts.
     * - Returns: The maximum total fruits that can be collected.
     */
    func maxCollectedFruits(_ fruits: [[Int]]) -> Int {
        let n = fruits.count
        // Edge case: If the grid is empty or 1x1, the logic below handles it,
        // but for clarity, a 1x1 grid's sum is just its single element.
        if n <= 1 { return fruits.first?.first ?? 0 }

        // 1. Collector 1: Sum all fruits along the main diagonal (from top-left to bottom-right).
        // This path is fixed and its sum is part of the total.
        let mainDiagonalSum = (0..<n).reduce(0) { sum, i in sum + fruits[i][i] }

        // --- DP Setup for Collectors 2 and 3 ---
        // `topRightPathDP[i]` will store the max fruits collected by the collector starting
        // from the top-right, after a certain number of steps, ending at an offset `i` from the edge.
        var topRightPathDP = [Int](repeating: 0, count: 3)
        // Initialize with the starting fruit at the top-right corner.
        topRightPathDP[0] = fruits[0][n - 1]

        // `bottomLeftPathDP[i]` does the same for the collector from the bottom-left.
        var bottomLeftPathDP = [Int](repeating: 0, count: 3)
        // Initialize with the starting fruit at the bottom-left corner.
        bottomLeftPathDP[0] = fruits[n - 1][0]

        // `searchWindowSize` defines the width of our DP calculation. It expands and then
        // contracts, creating a diamond-shaped search area from the corners towards the center.
        var searchWindowSize = 2

        // 2. Collectors 2 & 3: Iterate from the corners towards the main diagonal.
        // The `step` variable tracks the progression (row for top-right, column for bottom-left).
        for step in 1..<(n - 1) {
            // DP tables for the next state.
            var nextTopRightDP = [Int](repeating: 0, count: searchWindowSize + 2)
            var nextBottomLeftDP = [Int](repeating: 0, count: searchWindowSize + 2)

            // Iterate through all possible positions within the current window.
            for offset in 0..<searchWindowSize {
                // --- Calculate path from Top-Right ---
                // The value at a new DP state is the current fruit plus the max of the 3 possible previous states.
                let prevLeft = offset > 0 ? topRightPathDP[offset - 1] : 0
                let prevCenter = topRightPathDP[offset]
                let prevRight = offset + 1 < topRightPathDP.count ? topRightPathDP[offset + 1] : 0
                
                // The current cell for the top-right collector is at row `step` and column `n - 1 - offset`.
                let currentFruitTopRight = fruits[step][n - 1 - offset]
                nextTopRightDP[offset] = max(prevLeft, prevCenter, prevRight) + currentFruitTopRight

                // --- Calculate path from Bottom-Left ---
                // Same logic for the bottom-left collector.
                let prevUp = offset > 0 ? bottomLeftPathDP[offset - 1] : 0
                let prevMiddle = bottomLeftPathDP[offset]
                let prevDown = offset + 1 < bottomLeftPathDP.count ? bottomLeftPathDP[offset + 1] : 0

                // The current cell for the bottom-left collector is at row `n - 1 - offset` and column `step`.
                let currentFruitBottomLeft = fruits[n - 1 - offset][step]
                nextBottomLeftDP[offset] = max(prevUp, prevMiddle, prevDown) + currentFruitBottomLeft
            }

            // Update the DP tables for the next iteration.
            topRightPathDP = nextTopRightDP
            bottomLeftPathDP = nextBottomLeftDP

            // Adjust the window size. It grows until the paths are about to meet/cross, then shrinks.
            // This obscure formula defines the diamond-shaped exploration area.
            if searchWindowSize - n + 4 + step <= 1 {
                searchWindowSize += 1
            } else if searchWindowSize - n + 3 + step > 1 {
                searchWindowSize -= 1
            }
        }

        // 3. Final Calculation:
        // The total is the sum from the main diagonal plus the max collected from the other two paths.
        // `topRightPathDP[0]` and `bottomLeftPathDP[0]` hold the maximum values for the paths
        // that end closest to the main diagonal.
        return mainDiagonalSum + topRightPathDP[0] + bottomLeftPathDP[0]
    }
}