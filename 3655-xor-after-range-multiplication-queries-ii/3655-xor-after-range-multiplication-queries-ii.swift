/**
 Problem Summary:
 Given an array `nums` and a list of queries, each query modifies elements in a range:
 - For query [l, r, k, v]:
   - Multiply every k-th element in range [l, r] by v (modulo 1e9+7).
 After applying all queries, return the XOR of the final array.

 Strategy:
 - Convert array to Int64 for safe modular arithmetic.
 - Handle two cases:
   1. k > 1 → directly update elements (sparse updates).
   2. k == 1 → range multiplication → use difference map (`delta`) to apply efficiently.
 - Use prefix product accumulation for range updates.
 - Finally compute XOR of resulting array.

 Time Complexity:
 - Worst case: O(Q * N/k + N)
   - Sparse updates for k > 1
   - Prefix pass for k == 1
 - In worst case (k=1 always): O(N + Q)

 Space Complexity:
 - O(N + Q) due to array + delta map
 */

class Solution {

    private let mod: Int64 = 1_000_000_007

    func xorAfterQueries(_ nums: [Int], _ queries: [[Int]]) -> Int {
        let n = nums.count
        
        // Use Int64 to avoid overflow during multiplication
        var values = nums.map { Int64($0) }
        
        // Difference map for range multiplication (k == 1 case)
        var rangeMultiplierDiff: [Int: Int64] = [:]

        for query in queries {
            let left = query[0]
            let right = query[1]
            let step = query[2]
            let multiplier = query[3]

            // Multiplying by 1 has no effect
            if multiplier == 1 { continue }

            if step > 1 {
                // Sparse updates: directly update affected indices
                var index = left
                while index <= right {
                    values[index] = (values[index] * Int64(multiplier)) % mod
                    index += step
                }
            } else {
                // Range multiplication using difference technique
                let multiplierValue = Int64(multiplier)

                rangeMultiplierDiff[left] =
                    ((rangeMultiplierDiff[left] ?? 1) * multiplierValue) % mod

                // Apply modular inverse at right + 1 to stop effect
                let inverse = modularExponentiation(multiplierValue, mod - 2)
                rangeMultiplierDiff[right + 1] =
                    ((rangeMultiplierDiff[right + 1] ?? 1) * inverse) % mod
            }
        }

        // Apply accumulated range multipliers (prefix product)
        var currentMultiplier: Int64 = 1

        for index in 0..<n {
            if let diffValue = rangeMultiplierDiff[index] {
                currentMultiplier = (currentMultiplier * diffValue) % mod
            }

            if currentMultiplier != 1 {
                values[index] = (values[index] * currentMultiplier) % mod
            }
        }

        // Compute XOR of final values
        var xorResult: Int64 = 0
        for value in values {
            xorResult ^= value
        }

        return Int(xorResult)
    }

    /**
     Fast modular exponentiation (binary exponentiation)
     Used to compute modular inverse via Fermat’s Little Theorem:
     a^(mod-2) % mod
     */
    private func modularExponentiation(_ base: Int64, _ exponent: Int64) -> Int64 {
        var result: Int64 = 1
        var base = base % mod
        var exponent = exponent

        while exponent > 0 {
            if exponent & 1 == 1 {
                result = (result * base) % mod
            }
            base = (base * base) % mod
            exponent >>= 1
        }

        return result
    }
}