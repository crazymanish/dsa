/**
 Problem Summary:
 Alice and Bob take stones from a pile. On each turn, a player may take
 between 1 and 2 * M piles, then M becomes max(M, takenCount).
 Return the maximum number of stones Alice can collect.

 Strategy:
 Use minimax recursion with memoization.
 For each state, calculate the maximum score difference:
 Alice's current stones - Bob's future advantage.

 Time Complexity:
 O(n^3)

 Space Complexity:
 O(n^2)
 */
class Solution {
    func stoneGameII(_ piles: [Int]) -> Int {
        let pilesCount = piles.count
        guard pilesCount > 0 else { return 0 }

        // dpCache[index][maximumTake] stores the best score difference
        // the current player can achieve from this state.
        var dpCache = Array(
            repeating: Array(repeating: -1, count: 2 * pilesCount + 1),
            count: pilesCount + 1
        )

        // Calculate the total number of stones for the final score conversion.
        let totalStones = piles.reduce(0, +)

        func playStoneGame(_ startIndex: Int, _ maximumTake: Int) -> Int {
            // No piles remain, so there is no further score difference.
            guard startIndex < pilesCount else { return 0 }

            if dpCache[startIndex][maximumTake] != -1 {
                return dpCache[startIndex][maximumTake]
            }

            var stonesTaken = 0
            var bestScoreDifference = Int.min

            // Try taking every valid number of piles from 1 through 2 * M.
            for takenCount in 1...(2 * maximumTake) {
                let currentIndex = startIndex + takenCount - 1

                // Stop adding stones once we move past the final pile.
                if currentIndex >= pilesCount {
                    break
                }

                stonesTaken += piles[currentIndex]

                // The opponent's advantage becomes our disadvantage.
                let opponentDifference = playStoneGame(
                    currentIndex + 1,
                    max(maximumTake, takenCount)
                )

                let currentScoreDifference = stonesTaken - opponentDifference
                bestScoreDifference = max(
                    bestScoreDifference,
                    currentScoreDifference
                )
            }

            dpCache[startIndex][maximumTake] = bestScoreDifference
            return bestScoreDifference
        }

        // The recursive result represents Alice's score minus Bob's score.
        let scoreDifference = playStoneGame(0, 1)

        // Alice's score = (total stones + score difference) / 2.
        return (totalStones + scoreDifference) / 2
    }
}