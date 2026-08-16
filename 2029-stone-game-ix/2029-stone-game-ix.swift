class Solution {
    /**
     Problem Summary:
     Two players remove stones while tracking the running sum modulo 3.
     A player loses if their move makes the running sum divisible by 3.
     Determine whether Alice can force a win.

     Strategy:
     - Count stones based on their remainder when divided by 3.
     - Try both meaningful starting moves: remainder `1` and remainder `2`.
     - After the first move, remainder `1` and `2` stones must alternate to avoid
       making the running sum divisible by 3.
     - Remainder `0` stones do not change the running remainder, but they affect
       whose turn it is when one remainder group runs out.

     Time Complexity:
     O(n), where n is the number of stones.

     Space Complexity:
     O(1), since only three remainder counts are stored.
     */
    func stoneGameIX(_ stones: [Int]) -> Bool {
        let remainderCounts = stones.reduce(into: [0, 0, 0]) {
            $0[$1 % 3] += 1
        }

        // Alice must begin with a remainder 1 or remainder 2 stone.
        guard remainderCounts[1] + remainderCounts[2] > 0 else {
            return false
        }

        func canWin(startingRemainder: Int) -> Bool {
            var remainingCounts = remainderCounts
            var currentRemainder: Int

            // Make Alice's first move.
            if startingRemainder == 1 {
                guard remainingCounts[1] > 0 else { return false }

                currentRemainder = 1
                remainingCounts[1] -= 1
            } else {
                guard remainingCounts[2] > 0 else { return false }

                currentRemainder = 2
                remainingCounts[2] -= 1
            }

            let remainingNonZeroStones = remainingCounts[1] + remainingCounts[2]

            // To avoid a sum divisible by 3:
            // remainder 1 must be followed by remainder 1,
            // while remainder 2 must be followed by remainder 2.
            // This changes the accumulated remainder between 1 and 2.
            for moveIndex in 0..<remainingNonZeroStones {
                if currentRemainder == 1 {
                    if remainingCounts[1] == 0 {
                        // Remainder-0 stones only affect turn parity.
                        return (moveIndex + remainingCounts[0]) % 2 == 0
                    }

                    remainingCounts[1] -= 1
                    currentRemainder = 2
                } else {
                    if remainingCounts[2] == 0 {
                        // Remainder-0 stones only affect turn parity.
                        return (moveIndex + remainingCounts[0]) % 2 == 0
                    }

                    remainingCounts[2] -= 1
                    currentRemainder = 1
                }
            }

            return false
        }

        // Alice may start with either remainder group if available.
        return canWin(startingRemainder: 1) || canWin(startingRemainder: 2)
    }
}