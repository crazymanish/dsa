/**
 Problem Summary:
 Given an array of stones, players repeatedly merge a prefix of at least
 two piles and add the merged sum to their score. Alice wants to maximize
 the final score difference, while Bob wants to minimize it.

 Strategy:
 Use prefix sums and dynamic programming from right to left.

 Let `bestScoreDifference` represent the maximum score difference the
 current player can guarantee after considering a prefix ending at the
 current position.

 For a prefix ending at `index`, there are two possibilities:
 1. Keep the previously computed optimal result.
 2. Merge through `index`, gaining `prefixSums[index]`, after which the
    opponent can obtain `bestScoreDifference`.

 Therefore:
 bestScoreDifference = max(
     bestScoreDifference,
     prefixSums[index] - bestScoreDifference
 )

 Processing from right to left allows us to keep only one DP value.

 Time Complexity:
 O(n) — one pass to build prefix sums and one reverse pass.

 Space Complexity:
 O(n) — prefix sums are stored for all positions.
 */
class Solution {
    func stoneGameVIII(_ stones: [Int]) -> Int {
        var prefixSums = [Int]()
        var runningSum = 0

        // Build prefix sums so each possible merged prefix value
        // can be retrieved in O(1).
        for stone in stones {
            runningSum += stone
            prefixSums.append(runningSum)
        }

        let lastIndex = stones.count - 1

        // If all stones are merged, the resulting prefix sum is the
        // initial score difference for our right-to-left DP.
        var bestScoreDifference = prefixSums[lastIndex]

        // Work backwards through every valid prefix containing
        // at least two stones.
        for index in (1..<lastIndex).reversed() {
            // Choosing this prefix gives its sum to the current player,
            // while the opponent can subsequently achieve
            // `bestScoreDifference`.
            let scoreDifferenceAfterMerge =
                prefixSums[index] - bestScoreDifference

            bestScoreDifference = max(
                bestScoreDifference,
                scoreDifferenceAfterMerge
            )
        }

        return bestScoreDifference
    }
}