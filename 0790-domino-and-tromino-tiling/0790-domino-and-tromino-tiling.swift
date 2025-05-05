class Solution {
    /**
     * Calculates the number of ways to tile a 2xN board using 2x1 dominoes and trominoes.
     * The result is returned modulo 1_000_000_007.
     *
     * Reference for DP states and transitions: https://leetcode.com/problems/domino-and-tromino-tiling/solutions/116581/detail-and-explanation-of-dp-solution-why-dp-i-2-dp-i-1-dp-i-1-1/
     *
     * - Parameter n: The width of the 2xN board.
     * - Returns: The number of tiling ways modulo 1_000_000_007.
     *
     * - Time Complexity: O(N).
     * - We iterate from 3 to N, performing constant-time calculations in each step.
     *
     * - Space Complexity: O(N).
     * - We use two arrays (`fullyTiledWays`, `partiallyTiledWays`) of size N+1 to store the DP states.
     * * Optimization Note: Space can be optimized to O(1) because each state `dp[i]` only depends
     * on `dp[i-1]` and `dp[i-2]`. We could use constant variables to store the previous two states instead of full arrays.
     */
    func numTilings(_ n: Int) -> Int {
        // Base cases:
        // n=0: 0 ways (or 1 way depending on interpretation, but problem constraints likely start n>=1)
        // n=1: 1 way (one vertical domino)
        // n=2: 2 ways (two vertical dominoes or two horizontal dominoes)
        if n <= 2 { return n }

        // Modulo constant to prevent overflow.
        let modNum = 1_000_000_007

        // DP arrays:
        // fullyTiledWays[i]: Number of ways to fully tile a 2xi board.
        // partiallyTiledWays[i]: Number of ways to tile a 2xi board with one corner (top-right or bottom-right) uncovered.
        // Size n+1 to use 1-based indexing matching the problem description (1 to n).
        var fullyTiledWays = Array(repeating: 0, count: n + 1)
        var partiallyTiledWays = Array(repeating: 0, count: n + 1)

        // Initialize base cases for the DP arrays:
        fullyTiledWays[0] = 1 // Conceptually, 1 way to tile a 2x0 board (do nothing) - useful for transitions.
        fullyTiledWays[1] = 1 // One vertical domino.
        partiallyTiledWays[1] = 0 // Cannot partially tile 2x1 board this way.

        fullyTiledWays[2] = 2 // Two vertical or two horizontal dominoes.
        partiallyTiledWays[2] = 1 // Place one tromino covering (1,1), (2,1), (1,2) OR (1,1), (2,1), (2,2). By symmetry, count is 1 for each *type* of partial state. The DP state combines these.

        // Fill the DP table from i = 3 to n.
        for i in 3...n {
            // Calculate fullyTiledWays[i]:
            // 1. Add a vertical domino to a fully tiled 2x(i-1) board: fullyTiledWays[i-1]
            // 2. Add two horizontal dominoes to a fully tiled 2x(i-2) board: fullyTiledWays[i-2]
            // 3. Add a tromino to a partially tiled 2x(i-1) board (top corner missing): partiallyTiledWays[i-1]
            // 4. Add a tromino to a partially tiled 2x(i-1) board (bottom corner missing): partiallyTiledWays[i-1]
            // Combine these using modulo arithmetic at each step.
            fullyTiledWays[i] = (fullyTiledWays[i-1] + fullyTiledWays[i-2]) % modNum
            let waysFromPartial = (partiallyTiledWays[i-1] + partiallyTiledWays[i-1]) % modNum // 2 * partial[i-1]
            fullyTiledWays[i] = (fullyTiledWays[i] + waysFromPartial) % modNum

            // Calculate partiallyTiledWays[i]:
            // 1. Add a tromino covering one square in col i-1 and two in col i, starting from fully tiled 2x(i-2): fullyTiledWays[i-2]
            // 2. Add a horizontal domino to the covered row of a partially tiled 2x(i-1): partiallyTiledWays[i-1]
            // Combine these using modulo arithmetic.
            partiallyTiledWays[i] = (fullyTiledWays[i-2] + partiallyTiledWays[i-1]) % modNum
        }

        // The final answer is the number of ways to fully tile the 2xn board.
        // Apply modulo one last time just in case (though it should already be applied).
        return fullyTiledWays[n] % modNum
    }
}
