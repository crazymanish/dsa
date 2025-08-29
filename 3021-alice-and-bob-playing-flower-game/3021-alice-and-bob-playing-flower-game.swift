// Time Complexity: O(1)
// The solution involves a fixed number of arithmetic operations to calculate the number
// of odd and even integers and their products. The runtime does not depend on the
// magnitude of `n` or `m`.
//
// Space Complexity: O(1)
// The algorithm uses a few constant-size variables to store counts. No extra space
// that scales with the input is required.
class Solution {
    /**
     * Calculates the number of starting pairs (x, y) for which Alice wins the flower game.
     *
     * ## Game Theory Insight:
     * This is an impartial game, meaning the available moves depend only on the state
     * of the game, not on which player is moving. The winner of such games is often
     * determined by the total number of moves.
     *
     * - Total flowers = `x + y`.
     * - Each turn, one flower is removed.
     * - Total number of turns in the game = `x + y`.
     *
     * Alice takes the 1st, 3rd, 5th, ... (odd) turns. Bob takes the 2nd, 4th, 6th, ... (even) turns.
     * The player who takes the last flower wins. For Alice to win, the last turn must be an odd number.
     * Therefore, the total number of turns, `x + y`, must be **odd**.
     *
     * ## Counting Strategy:
     * For `x + y` to be odd, one number must be odd and the other must be even. We count the
     * number of pairs (x, y) that satisfy this condition within the given ranges [1, n] and [1, m].
     *
     * - Case 1: `x` is odd and `y` is even.
     * - Case 2: `x` is even and `y` is odd.
     *
     * The total number of winning pairs is the sum of the counts from these two cases.
     *
     * - Parameter n: The maximum number of flowers in the first lane.
     * - Parameter m: The maximum number of flowers in the second lane.
     * - Returns: The total number of (x, y) pairs where Alice wins.
     */
    func flowerGame(_ n: Int, _ m: Int) -> Int {
        // --- Count of odd and even numbers in the range [1, n] ---
        // For a range [1, k], there are k/2 even numbers and (k+1)/2 odd numbers
        // using integer division.
        let evenCountN = n / 2
        let oddCountN = (n + 1) / 2

        // --- Count of odd and even numbers in the range [1, m] ---
        let evenCountM = m / 2
        let oddCountM = (m + 1) / 2
        
        // Case 1: Number of pairs where x is odd (from [1,n]) and y is even (from [1,m]).
        let oddX_evenY = oddCountN * evenCountM
        
        // Case 2: Number of pairs where x is even (from [1,n]) and y is odd (from [1,m]).
        let evenX_oddY = evenCountN * oddCountM
        
        // The total number of winning pairs is the sum of the two cases.
        // Note: The result can exceed the capacity of a 32-bit integer. Swift's `Int`
        // is 64-bit on modern platforms, which is sufficient to prevent overflow.
        return oddX_evenY + evenX_oddY
    }
}