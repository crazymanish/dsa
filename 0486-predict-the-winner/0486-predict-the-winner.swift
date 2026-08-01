final class Solution {
    /*
     Problem Summary:
     Determine whether Player 1 can win or tie when both players
     optimally choose a number from either end of the array.

     Strategy:
     Use recursive minimax with memoization. Each state tracks whose
     turn it is, the current score difference, and the remaining range.

     Time Complexity:
     O(n² × S), where S is the number of possible score-difference values.

     Space Complexity:
     O(n² × S) for the memoization cache and recursion stack.
     */

    func predictTheWinner(_ nums: [Int]) -> Bool {
        let lastIndex = nums.count - 1
        let keyBase = 100 // Supports the input constraints used by the key encoding.
        var memo: [Int: Bool] = [:]

        func canPlayerOneWin(
            isPlayerOneTurn: Bool,
            scoreDifference: Int,
            leftIndex: Int,
            rightIndex: Int
        ) -> Bool {
            // Encode the complete state into one memoization key.
            let stateKey =
                scoreDifference * keyBase * keyBase
                + leftIndex * keyBase
                + rightIndex

            if let cachedResult = memo[stateKey] {
                return cachedResult
            }

            let result: Bool

            if leftIndex == rightIndex {
                // Player 1 wins on a tie, while Player 2 must win strictly.
                let remainingScore = nums[leftIndex] - scoreDifference
                result = isPlayerOneTurn
                    ? remainingScore >= 0
                    : remainingScore > 0
            } else {
                // Try taking the number from the left end.
                let takeLeftResult = canPlayerOneWin(
                    isPlayerOneTurn: !isPlayerOneTurn,
                    scoreDifference: nums[leftIndex] - scoreDifference,
                    leftIndex: leftIndex + 1,
                    rightIndex: rightIndex
                )

                // Try taking the number from the right end.
                let takeRightResult = canPlayerOneWin(
                    isPlayerOneTurn: !isPlayerOneTurn,
                    scoreDifference: nums[rightIndex] - scoreDifference,
                    leftIndex: leftIndex,
                    rightIndex: rightIndex - 1
                )

                // The current player succeeds if at least one choice
                // prevents the opponent from winning.
                result = !takeLeftResult || !takeRightResult
            }

            memo[stateKey] = result
            return result
        }

        return canPlayerOneWin(
            isPlayerOneTurn: true,
            scoreDifference: 0,
            leftIndex: 0,
            rightIndex: lastIndex
        )
    }
}