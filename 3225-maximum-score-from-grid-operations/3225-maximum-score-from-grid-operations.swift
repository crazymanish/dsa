class Solution {
    /**
     Problem Summary:
     ----------------
     We process the grid column by column. For each column, we select a segment
     (range of rows) and gain score based on the sum of that segment.

     The goal is to maximize the total score across all columns while maintaining
     valid transitions between segments of consecutive columns.

     Strategy:
     ---------
     - Use prefix sums per column for O(1) range sum queries.
     - Use DP where dp[prevStart][prevEnd] represents the best score up to the previous column.
     - For each column:
         - Try all possible "pivot" (middle boundary).
         - Precompute segment gains.
         - Use prefix and suffix maximum arrays to optimize transitions.

     Time Complexity: O(n^3)
     Space Complexity: O(n^2)
     */
    func maximumScore(_ grid: [[Int]]) -> Int {
        let n = grid.count
        if n == 1 { return 0 }

        // columnPrefixSum[col][row] = sum of grid[0...row-1][col]
        var columnPrefixSum = Array(
            repeating: Array(repeating: 0, count: n + 1),
            count: n
        )

        // Build prefix sums for each column
        for col in 0..<n {
            var runningSum = 0
            for row in 0..<n {
                runningSum += grid[row][col]
                columnPrefixSum[col][row + 1] = runningSum
            }
        }

        let NEG_INF = Int.min / 4

        // dp[prevStart][prevEnd] = maximum score up to previous column
        var dp = Array(
            repeating: Array(repeating: NEG_INF, count: n + 1),
            count: n + 1
        )

        // Initialize DP using the first column
        for startRow in 0...n {
            for endRow in 0...n {
                // Gain from selecting segment [startRow, endRow)
                let segmentSum = columnPrefixSum[0][endRow] - columnPrefixSum[0][startRow]
                dp[startRow][endRow] = max(0, segmentSum)
            }
        }

        // Process columns from left to right
        for col in 1..<n {
            var nextDP = Array(
                repeating: Array(repeating: NEG_INF, count: n + 1),
                count: n + 1
            )

            // Try all possible "middle boundaries"
            for middleRow in 0...n {

                // segmentGain[end] = gain of selecting segment [middleRow, end)
                var segmentGain = Array(repeating: 0, count: n + 1)
                for endRow in 0...n {
                    let segmentSum = columnPrefixSum[col][endRow] - columnPrefixSum[col][middleRow]
                    segmentGain[endRow] = max(0, segmentSum)
                }

                // prefixBest[i] = best dp[start <= i][middleRow]
                var prefixBest = Array(repeating: NEG_INF, count: n + 1)
                prefixBest[0] = dp[0][middleRow]

                for startRow in 1...n {
                    // Keep track of the best previous state where startRow <= current index
                    prefixBest[startRow] = max(prefixBest[startRow - 1], dp[startRow][middleRow])
                }

                // suffixBest[i] = best dp[start >= i][middleRow] + segmentGain[start]
                var suffixBest = Array(repeating: NEG_INF, count: n + 2)
                suffixBest[n] = dp[n][middleRow] + segmentGain[n]

                for startRow in stride(from: n - 1, through: 0, by: -1) {
                    // Either extend from next or take current startRow
                    suffixBest[startRow] = max(
                        suffixBest[startRow + 1],
                        dp[startRow][middleRow] + segmentGain[startRow]
                    )
                }

                // If last column, we must end at row 0 (problem constraint)
                let nextEndLimit = (col == n - 1) ? 0 : n

                for nextEndRow in 0...nextEndLimit {

                    var bestTransition = NEG_INF

                    // Case 1: previous startRow <= nextEndRow
                    if prefixBest[nextEndRow] != NEG_INF {
                        bestTransition = max(
                            bestTransition,
                            prefixBest[nextEndRow] + segmentGain[nextEndRow]
                        )
                    }

                    // Case 2: previous startRow > nextEndRow
                    if suffixBest[nextEndRow + 1] != NEG_INF {
                        bestTransition = max(
                            bestTransition,
                            suffixBest[nextEndRow + 1]
                        )
                    }

                    // Update DP for next column
                    nextDP[middleRow][nextEndRow] = max(
                        nextDP[middleRow][nextEndRow],
                        bestTransition
                    )
                }
            }

            // Move to next column
            dp = nextDP
        }

        // Extract the maximum score from final DP table
        var maxScore = 0
        for row in dp {
            maxScore = max(maxScore, row.max() ?? 0)
        }

        return maxScore
    }
}