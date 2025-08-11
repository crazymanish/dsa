// Time Complexity: O(log n + Q * k)
//   - n: The input integer.
//   - Q: The number of queries.
//   - k: The number of set bits in `n`'s binary representation (k <= log2(n)).
//   - Deconstructing `n` into its powers of 2 takes O(log n) time.
//   - Processing each of the `Q` queries requires iterating from `left` to `right`. In the
//     worst case, this is O(k) for each query. This leads to O(Q * k).
//   - The total complexity is dominated by these two parts.
//
// Space Complexity: O(k)
//   - We need to store the `powers` array, which has a size `k` (the number of set bits in `n`).
class Solution {
    /**
     * Answers product queries on the powers of 2 that sum to n.
     *
     * - Parameters:
     * - n: An integer to be decomposed into a sum of unique powers of 2.
     * - queries: An array of [left, right] index pairs.
     * - Returns: An array of product results for each query, modulo 1,000,000,007.
     */
    func productQueries(_ n: Int, _ queries: [[Int]]) -> [Int] {
        var results = [Int]()
        let MOD = 1_000_000_007
        
        // --- Step 1: Deconstruct n into its constituent powers of 2 ---
        // Any integer can be uniquely represented as a sum of powers of 2,
        // which corresponds to the '1's in its binary representation.
        // Example: n = 15 (binary '1111') -> powersOf2 = [1, 2, 4, 8]
        var powersOf2 = [Int]()
        var currentPower = 1
        var remainingN = n
        
        while remainingN > 0 {
            // If the last bit is 1, this power of 2 is part of the sum.
            if remainingN % 2 == 1 {
                powersOf2.append(currentPower)
            }
            // Move to the next power of 2 and the next bit.
            currentPower *= 2
            remainingN /= 2
        }
        
        // --- Step 2: Process each query ---
        for query in queries {
            let left = query[0]
            let right = query[1]
            var currentProduct: Int = 1
            
            // Calculate the product of elements in the specified range.
            for i in stride(from: left, to: right + 1, by: 1) {
                // Use a 64-bit integer for the intermediate multiplication to prevent overflow
                // before applying the modulo, although with modulo at each step it's not strictly necessary.
                currentProduct = (currentProduct * powersOf2[i]) % MOD
            }
            results.append(currentProduct)
        }
        
        return results
    }
}