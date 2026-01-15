class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(h log h + v log v)
    ///     - h = hBars.count
    ///     - v = vBars.count
    ///     Sorting dominates the runtime.
    ///
    /// Space Complexity:
    ///   • O(1) extra space
    ///     (Ignoring the space used by sorting.)
    ///
    /// Problem Summary:
    ///   We are given a grid with horizontal and vertical bars removed.
    ///   A square hole can be formed if we have consecutive removed bars
    ///   in BOTH directions.
    ///
    /// Key Insight:
    ///   - If there are k consecutive removed bars in one direction,
    ///     the maximum hole length in that direction is (k + 1).
    ///   - The largest square hole is limited by the smaller dimension
    ///     of the two directions.
    /// -----------------------------------------------------------------------
    func maximizeSquareHoleArea(_ n: Int, _ m: Int, _ hBars: [Int], _ vBars: [Int]) -> Int {
        /// Returns the length of the longest run of consecutive integers
        /// in a sorted list of bar indices.
        func longestConsecutiveRun(_ bars: [Int]) -> Int {
            // If zero or one bar is removed, the run length is 1
            guard bars.count > 1 else { return 1 }

            var longestRun = 1
            var currentRun = 1

            for index in 0..<(bars.count - 1) {
                if bars[index] + 1 == bars[index + 1] {
                    currentRun += 1
                } else {
                    currentRun = 1
                }
                longestRun = max(longestRun, currentRun)
            }

            return longestRun
        }

        // Sort removed bars in both directions
        let sortedHorizontalBars = hBars.sorted()
        let sortedVerticalBars = vBars.sorted()

        // Maximum side length is limited by the smaller run
        let maxSideLength =
            min(
                longestConsecutiveRun(sortedHorizontalBars),
                longestConsecutiveRun(sortedVerticalBars)
            ) + 1

        // Return area of the largest possible square hole
        return maxSideLength * maxSideLength
    }
}
