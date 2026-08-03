final class Solution {
    /*
     Problem Summary:
     Alice and Bob alternately take one, two, or three piles from the front.
     Return the winner when both players play optimally.

     Strategy:
     Use top-down dynamic programming.
     `bestScoreDifference(from:)` returns the maximum score difference
     (current player - opponent) from the given index.

     Time Complexity: O(n)
     Space Complexity: O(n)
     */

    func stoneGameIII(_ piles: [Int]) -> String {
        let pileCount = piles.count
        var memo = Array(repeating: Optional<Int>.none, count: pileCount + 1)

        // Calculate the total number of stones for both players combined.
        let totalStones = piles.reduce(0, +)

        func bestScoreDifference(from startIndex: Int) -> Int {
            // No piles remain, so the current player cannot gain any points.
            if startIndex == pileCount {
                return 0
            }

            if let cachedDifference = memo[startIndex] {
                return cachedDifference
            }

            var currentPlayerStones = 0
            var bestDifference = Int.min

            // The current player may take one, two, or three piles.
            let maximumPilesToTake = min(3, pileCount - startIndex)

            for pilesTaken in 1...maximumPilesToTake {
                currentPlayerStones += piles[startIndex + pilesTaken - 1]

                // After taking these piles, the opponent becomes the
                // current player. Their advantage reduces our difference.
                let opponentDifference = bestScoreDifference(
                    from: startIndex + pilesTaken
                )

                let scoreDifference = currentPlayerStones - opponentDifference
                bestDifference = max(bestDifference, scoreDifference)
            }

            memo[startIndex] = bestDifference
            return bestDifference
        }

        // Let scoreDifference = Alice's score - Bob's score.
        let scoreDifference = bestScoreDifference(from: 0)

        // Recover each player's score from their total and difference.
        let aliceScore = (totalStones + scoreDifference) / 2
        let bobScore = totalStones - aliceScore

        if aliceScore > bobScore {
            return "Alice"
        } else if aliceScore < bobScore {
            return "Bob"
        } else {
            return "Tie"
        }
    }
}