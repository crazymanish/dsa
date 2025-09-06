// Time Complexity: O(Q * log K)
//   - Q: The number of queries.
//   - K: The maximum value of an endpoint in the queries.
//   - The `prefixSumOfOps` function runs in logarithmic time, O(log K), because its loop
//     is based on powers of 4.
//   - The `minOperations` function calls `prefixSumOfOps` twice for each of the Q queries.
//   - Therefore, the total complexity is O(Q * log K).
//
// Space Complexity: O(1)
//   - The solution uses a fixed number of variables. The space required does not scale
//     with the number of queries or the magnitude of their values.
class Solution {
    /**
     * Calculates the sum of operations over a series of integer ranges (queries).
     * This solution assumes the problem is to sum up the number of turns the first
     * player (Alice) would make in a game played on each query's range.
     *
     * The total number of moves in a game for a range `[a, b]` is `T = sum(ops(i))` for `i` from `a` to `b`,
     * where `ops(i)` is the number of digits in the base-4 representation of `i`.
     * The number of turns for the first player in a game of `T` moves is `ceil(T / 2.0)`,
     * which can be calculated using integer division as `(T + 1) / 2`.
     *
     * We use a prefix-sum style helper function, `prefixSumOfOps`, to efficiently
     * calculate `T` for any range.
     */
    func minOperations(_ queries: [[Int]]) -> Int {
        var totalAliceMoves = 0
        
        for query in queries {
            let start = query[0]
            let end = query[1]
            
            // Calculate the total operations `T` for the range [start, end].
            // T = (sum of ops up to `end`) - (sum of ops up to `start - 1`)
            let sumOfOpsInRange = prefixSumOfOps(end) - prefixSumOfOps(start - 1)
            
            // Calculate the number of moves for the first player (Alice) and add to the total.
            let aliceMovesForQuery = (sumOfOpsInRange + 1) / 2
            totalAliceMoves += aliceMovesForQuery
        }
        
        return totalAliceMoves
    }
    
    /**
     * Calculates the prefix sum of operations up to a given limit.
     * An "operation" for a number `x` is defined as the number of digits in its
     * base-4 representation. This function computes `Sum_{i=1 to limit} ops(i)`.
     *
     * The calculation is optimized by processing numbers in blocks based on powers of 4.
     * - Numbers from 1 to 3 (4¹-1) have 1 digit in base 4.
     * - Numbers from 4 to 15 (4²-1) have 2 digits in base 4.
     * - Numbers from 16 to 63 (4³-1) have 3 digits in base 4, and so on.
     */
    private func prefixSumOfOps(_ limit: Int) -> Int {
        if limit <= 0 { return 0 }
        
        var totalOps = 0
        var numDigits = 1       // The number of base-4 digits for the current block of numbers.
        var powerOf4: Int = 1   // The start of the current block (1, 4, 16, ...).

        // Calculate the sum for all full blocks of numbers (e.g., [1,3], [4,15], etc.).
        while limit >= powerOf4 * 4 {
            let nextPowerOf4 = powerOf4 * 4
            let countInBlock = nextPowerOf4 - powerOf4
            totalOps += countInBlock * numDigits
            
            numDigits += 1
            powerOf4 = nextPowerOf4
        }
        
        // After the loop, `powerOf4` is the start of the final (potentially partial) block.
        // Add the sum for this last block of numbers from `powerOf4` up to the `limit`.
        let countInLastBlock = limit - powerOf4 + 1
        totalOps += countInLastBlock * numDigits
        
        return totalOps
    }
}
