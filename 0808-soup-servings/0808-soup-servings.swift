// Time Complexity: O(1)
// The input `n` is effectively capped at 4800. Any `n` larger than this returns 1.0 immediately.
// For `n <= 4800`, the complexity is determined by the number of states in our DP table.
// After scaling `n` down by 25, the number of states is roughly (4800/25)^2 ≈ 192^2,
// which is a constant number of calculations. A more descriptive complexity, if `n` were unbounded,
// would be O((N/25)^2) or simply O(N^2).
//
// Space Complexity: O(1)
// For the same reason, the space for the DP cache is bounded by a constant size: (192+1) x (192+1).
// If `n` were unbounded, the complexity would be O(N^2) for the cache.
class Solution {
    /**
     * Calculates the probability that soup A will finish first plus half the probability
     * that soup A and B finish at the same time.
     *
     * - Parameter n: The initial quantity in ml of each soup.
     * - Returns: The calculated probability.
     */
    func soupServings(_ n: Int) -> Double {
        // Optimization: For large N, the probability that soup A finishes first
        // (since it's served in equal or larger amounts in 3 of 4 options)
        // approaches 1.0 very quickly. 4800 is a pre-calculated empirical threshold
        // where the result is so close to 1.0 that we can return it directly
        // to pass precision requirements and avoid unnecessary computation.
        guard n <= 4800 else { return 1.0 }

        // Scale the problem down. All serving amounts are multiples of 25.
        // We can work with units of 25ml to drastically reduce the state space
        // of our DP table, making a 2D array feasible and efficient.
        // `m` is the number of 25ml units, rounded up.
        let m = (n + 24) / 25

        // DP table for memoization. `cache[i][j]` will store the calculated
        // probability for `i` units of soup A and `j` units of soup B.
        // Using a 2D array is much more efficient than a dictionary with string keys.
        var cache = [[Double?]](repeating: [Double?](repeating: nil, count: m + 1), count: m + 1)

        // This is a recursive helper function that implements the top-down DP.
        func calculateProbability(aUnits: Int, bUnits: Int) -> Double {
            // Base Case 1: Soup A finishes first (or at the same time as another serving finishes B).
            // This is a "success" state according to the problem, probability is 1.0.
            if aUnits <= 0 && bUnits > 0 {
                return 1.0
            }
            // Base Case 2: Both soups finish at the same time.
            // The problem defines this as contributing 0.5 to the final probability.
            if aUnits <= 0 && bUnits <= 0 {
                return 0.5
            }
            // Base Case 3: Soup B finishes first.
            // This is a "failure" state, probability is 0.0.
            if aUnits > 0 && bUnits <= 0 {
                return 0.0
            }

            // Memoization: If we have already computed this state, return the cached value.
            if let cachedResult = cache[aUnits][bUnits] {
                return cachedResult
            }
            
            // The four serving options, described in scaled units:
            // Op 1: 100ml A, 0ml B   => 4 units A, 0 units B
            // Op 2: 75ml A, 25ml B  => 3 units A, 1 unit B
            // Op 3: 50ml A, 50ml B  => 2 units A, 2 units B
            // Op 4: 25ml A, 75ml B  => 1 unit A, 3 units B
            let p1 = calculateProbability(aUnits: aUnits - 4, bUnits: bUnits - 0)
            let p2 = calculateProbability(aUnits: aUnits - 3, bUnits: bUnits - 1)
            let p3 = calculateProbability(aUnits: aUnits - 2, bUnits: bUnits - 2)
            let p4 = calculateProbability(aUnits: aUnits - 1, bUnits: bUnits - 3)

            // Each of the four operations is chosen with equal probability (0.25).
            let result = 0.25 * (p1 + p2 + p3 + p4)
            
            // Store the result in the cache before returning.
            cache[aUnits][bUnits] = result
            return result
        }

        // Start the calculation with `m` units of each soup.
        return calculateProbability(aUnits: m, bUnits: m)
    }
}