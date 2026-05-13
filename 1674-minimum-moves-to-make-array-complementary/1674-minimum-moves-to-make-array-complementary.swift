class Solution {
    /**
     Problem Summary:
     Given an even-length array `nums`, each pair `nums[i]` and `nums[n - 1 - i]`
     should sum to the same target value. In one move, any number can be changed
     to a value between `1` and `limit`. Return the minimum number of moves needed.

     Strategy:
     Use a difference array to track how many moves are needed for every possible
     target sum from `2` to `2 * limit`.

     For each mirrored pair:
     - Every target sum starts with a default cost of `2` moves.
     - Sums reachable by changing only one number cost `1` move.
     - The current pair sum costs `0` moves.

     After applying all pair contributions, prefix-sum the difference array to
     find the minimum total moves across all target sums.

     Time Complexity:
     O(n + limit), where `n` is the length of `nums`.

     Space Complexity:
     O(limit), for the difference array.
     */
    func minMoves(_ nums: [Int], _ limit: Int) -> Int {
        let maxPossibleSum = limit * 2
        var moveDifferences = Array(repeating: 0, count: maxPossibleSum + 2)

        let pairCount = nums.count / 2

        for leftIndex in 0..<pairCount {
            let rightIndex = nums.count - 1 - leftIndex

            let smallerValue = min(nums[leftIndex], nums[rightIndex])
            let largerValue = max(nums[leftIndex], nums[rightIndex])
            let currentPairSum = smallerValue + largerValue

            // By default, every target sum requires 2 moves for this pair.
            moveDifferences[2] += 2

            // Target sums from smallerValue + 1 to largerValue + limit
            // can be reached with only 1 move.
            moveDifferences[smallerValue + 1] -= 1
            moveDifferences[largerValue + limit + 1] += 1

            // The current pair sum requires 0 moves.
            moveDifferences[currentPairSum] -= 1
            moveDifferences[currentPairSum + 1] += 1
        }

        var minimumMoves = Int.max
        var currentMoveCount = 0

        // Only sums from 2 through 2 * limit are valid target sums.
        for targetSum in 2...maxPossibleSum {
            currentMoveCount += moveDifferences[targetSum]
            minimumMoves = min(minimumMoves, currentMoveCount)
        }

        return minimumMoves
    }
}