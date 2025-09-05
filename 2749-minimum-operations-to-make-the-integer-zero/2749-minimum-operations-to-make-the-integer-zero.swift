// Time Complexity: O(1)
// The loop iterates a small, fixed number of times (from 0 to 60). Inside the loop,
// all operations (arithmetic, bit count) are performed in constant time on fixed-size
// integers. Therefore, the overall time complexity is constant.
//
// Space Complexity: O(1)
// The algorithm uses only a few variables to store intermediate values, requiring
// a constant amount of space.
class Solution {
    /**
     * Finds the minimum number of operations `k` to make `num1` zero.
     *
     * ## Mathematical Derivation
     * In each of the `k` operations, we subtract `(2^i + num2)` from `num1`.
     * After `k` operations, the final state is:
     * `num1_final = num1 - (2^i_1 + num2) - (2^i_2 + num2) - ... - (2^i_k + num2)`
     *
     * We want `num1_final` to be 0:
     * `0 = num1 - k * num2 - (2^i_1 + 2^i_2 + ... + 2^i_k)`
     *
     * Rearranging the equation gives us the target sum we need to form:
     * `num1 - k * num2 = 2^i_1 + 2^i_2 + ... + 2^i_k`
     *
     * Let `target = num1 - k * num2`. The problem is now: for a given `k`, can `target`
     * be expressed as a sum of exactly `k` powers of two?
     *
     * ## Conditions for Sum of Powers of Two
     * A positive integer `X` can be expressed as a sum of exactly `k` powers of two if and only if:
     * 1. `X.nonzeroBitCount <= k`: The number of terms `k` must be at least the minimum
     * required number of terms, which is the number of set bits in `X`.
     * 2. `X >= k`: The sum `X` must be at least `k`, since the smallest power of two is 2⁰=1,
     * and we are summing `k` such terms.
     *
     * We can iterate through possible values of `k` from 0 to 60 (a safe upper bound for the
     * problem constraints) and check if these conditions are met. The first `k` that
     * satisfies them will be our answer.
     *
     * - Parameters:
     * - num1: The starting integer.
     * - num2: The integer to subtract in each operation along with a power of 2.
     * - Returns: The minimum number of operations `k`, or -1 if impossible.
     */
    func makeTheIntegerZero(_ num1: Int, _ num2: Int) -> Int {
        // We are looking for the smallest number of operations, `k`.
        // We can test values of `k` starting from 0. A loop up to 60-64 is a safe
        // upper bound because the bit count of any 64-bit integer cannot exceed 64.
        for k in 0...60 {
            // Calculate the target value that needs to be formed by the sum of k powers of 2.
            let target = num1 - num2 * k
            
            // Now, we check if this `target` can be formed with exactly `k` operations.
            // Based on our derivation, three conditions must be met:
            
            // Condition 1: The target sum must be non-negative.
            // Also, the sum of k powers of 2 (each >= 1) must be at least k.
            // So, `target >= k` must hold.
            let isSumPossible = (target >= k)
            
            // Condition 2: The number of operations `k` must be at least the minimum
            // number of powers of two required to form the target, which is its bit count.
            let isBitCountPossible = (target.nonzeroBitCount <= k)
            
            if isSumPossible && isBitCountPossible {
                // Since we are iterating `k` from smallest to largest, the first value
                // that satisfies the conditions is the minimum, so we can return it.
                return k
            }
        }
        
        // If the loop completes without finding a valid `k`, it's impossible.
        return -1
    }
}