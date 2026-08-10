/**
 Problem Summary:
 Determine whether the current player can force a win in the square game.
 Players alternately remove a non-zero perfect square from the remaining stones.

 Strategy:
 Use recursive dynamic programming.
 `canWin[remainingStones]` stores whether the current player can win
 when the given number of stones remains.

 A player wins if they can remove a square that leaves the opponent
 in a losing state.

 Time Complexity:
 O(n * √n)

 Space Complexity:
 O(n), including the memoization table and recursion stack.
 */
class Solution {
    func winnerSquareGame(_ n: Int) -> Bool {
        var canWin = Array<Bool?>(repeating: nil, count: n + 1)

        func playGame(_ remainingStones: Int) -> Bool {
            // No stones means the current player cannot make a move.
            if remainingStones == 0 {
                return false
            }

            // Reuse the previously computed result for this state.
            if let cachedResult = canWin[remainingStones] {
                return cachedResult
            }

            var squareRoot = 1

            while squareRoot * squareRoot <= remainingStones {
                let squareValue = squareRoot * squareRoot
                let remainingAfterMove = remainingStones - squareValue

                // If the opponent loses from the next state,
                // the current player can force a win.
                if !playGame(remainingAfterMove) {
                    canWin[remainingStones] = true
                    return true
                }

                squareRoot += 1
            }

            // Every available move allows the opponent to win.
            canWin[remainingStones] = false
            return false
        }

        return playGame(n)
    }
}