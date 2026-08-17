class Solution {
    /**
     Problem Summary:
     - Split the current row of stones into two non-empty parts.
     - Compare the sum of both parts:
       - If the left sum is smaller, Bob removes the right part.
       - If the right sum is smaller, Bob removes the left part.
       - If both sums are equal, Alice can choose which part remains.
     - Alice gains points equal to the sum of the remaining part.
     - Return the maximum score Alice can obtain.

     Strategy:
     - Use top-down dynamic programming on each interval [startIndex, endIndex].
     - For every possible split position, maintain the left and right sums incrementally.
     - Recursively solve only the side that remains after the split.
     - Memoize each interval so it is solved only once.

     Time Complexity:
     - O(n³)
       There are O(n²) intervals, and each interval can try O(n) split positions.
       The interval sum is also calculated in O(n), but this does not change
       the overall O(n³) complexity.

     Space Complexity:
     - O(n²) for the DP cache.
     - O(n) additional recursion stack space.
     */
    func stoneGameV(_ stoneValue: [Int]) -> Int {
        let stonesCount = stoneValue.count
        var dpCache = Array(
            repeating: Array(repeating: -1, count: stonesCount),
            count: stonesCount
        )

        func playStoneGame(_ startIndex: Int, _ endIndex: Int) -> Int {
            // A row containing zero or one stone cannot be split further.
            if startIndex >= endIndex { return 0 }

            // Reuse the result if this interval was already solved.
            if dpCache[startIndex][endIndex] != -1 {
                return dpCache[startIndex][endIndex]
            }

            // Calculate the total value of the current interval.
            var totalRowValue = 0
            for index in startIndex...endIndex {
                totalRowValue += stoneValue[index]
            }

            var maximumScore = 0

            // Start with everything on the right, then move one stone
            // at a time from the right partition into the left partition.
            var leftRowValue = 0
            var rightRowValue = totalRowValue

            for splitIndex in startIndex..<endIndex {
                leftRowValue += stoneValue[splitIndex]
                rightRowValue -= stoneValue[splitIndex]

                if leftRowValue < rightRowValue {
                    // Bob removes the larger right row, so the left row remains.
                    let possibleScore =
                        leftRowValue +
                        playStoneGame(startIndex, splitIndex)

                    maximumScore = max(maximumScore, possibleScore)

                } else if leftRowValue > rightRowValue {
                    // Bob removes the larger left row, so the right row remains.
                    let possibleScore =
                        rightRowValue +
                        playStoneGame(splitIndex + 1, endIndex)

                    maximumScore = max(maximumScore, possibleScore)

                } else {
                    // When both rows have equal value, Alice may choose
                    // whichever remaining row leads to the better future score.
                    let leftScore =
                        leftRowValue +
                        playStoneGame(startIndex, splitIndex)

                    let rightScore =
                        rightRowValue +
                        playStoneGame(splitIndex + 1, endIndex)

                    maximumScore = max(
                        maximumScore,
                        max(leftScore, rightScore)
                    )
                }
            }

            dpCache[startIndex][endIndex] = maximumScore
            return maximumScore
        }

        return playStoneGame(0, stonesCount - 1)
    }
}