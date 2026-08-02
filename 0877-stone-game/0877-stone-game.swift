class Solution {
    /*
     Problem Summary:
     Determine whether Alice wins when both players alternately take a pile
     from either end of the array.

     Strategy:
     Use memoized recursion where dp[start][end] represents the maximum
     score difference the current player can achieve over the opponent
     using piles[start...end].

     Time Complexity: O(n²)
     Space Complexity: O(n²), plus O(n) recursion stack
     */
    func stoneGame(_ piles: [Int]) -> Bool {
        let pileCount = piles.count

        // nil means the interval has not been computed yet.
        var scoreDifferenceCache = Array(
            repeating: Array(repeating: Int?.none, count: pileCount),
            count: pileCount
        )

        func bestScoreDifference(from startIndex: Int, to endIndex: Int) -> Int {
            // No piles remain, so the current player's score difference is zero.
            if startIndex > endIndex {
                return 0
            }

            if let cachedDifference = scoreDifferenceCache[startIndex][endIndex] {
                return cachedDifference
            }

            // Taking the left pile gives the current player its value,
            // then the opponent gets the best difference from the remaining interval.
            let takeLeft = piles[startIndex]
                - bestScoreDifference(from: startIndex + 1, to: endIndex)

            // Taking the right pile follows the same score-difference logic.
            let takeRight = piles[endIndex]
                - bestScoreDifference(from: startIndex, to: endIndex - 1)

            // The current player chooses the move with the better outcome.
            let bestDifference = max(takeLeft, takeRight)
            scoreDifferenceCache[startIndex][endIndex] = bestDifference

            return bestDifference
        }

        // Alice wins when she can achieve a positive score difference.
        return bestScoreDifference(from: 0, to: pileCount - 1) > 0
    }
}