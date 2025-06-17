// Time Complexity: O(maxSize + log(m))
// O(maxSize) is a one-time setup cost for the application's lifetime to precompute
// the factorials when the `combinatoricsCalculator` is first accessed.
// Each subsequent call is O(log(m)) due to the power function.

// Space Complexity: O(maxSize)
// The space is used by the `combinatoricsCalculator` instance to store the
// precomputed factorial tables.
class Solution {
    /**
     * Solves a combinatorial problem related to counting "good arrays".
     *
     * - Parameters:
     * - n: The length of the array.
     * - m: The upper bound for values in the array (i.e., values are in 1...m).
     * - k: The required number of adjacent pairs with equal values.
     * - Returns: The number of such good arrays, modulo 1,000,000,007.
     */
    func countGoodArrays(_ n: Int, _ m: Int, _ k: Int) -> Int {
        let mod = 1_000_000_007

        /// A file-private helper for handling all combinatorial math.
        /// By creating it as a global `let`, Swift ensures the expensive precomputation in its
        /// initializer runs exactly once, the first time it's needed.
        let combinatoricsCalculator = CombinatoricsCalculator()
        
        // 1. Choose `k` positions for the "equal" adjacent pairs from `n-1` slots.
        let waysToChoosePositions = combinatoricsCalculator.combinations(n - 1, k)
        
        // 2. Choose values:
        //    - `m` choices for the first element.
        //    - `m-1` choices for each of the `(n-1) - k` positions where elements must differ.
        let waysToChooseValues = (m * combinatoricsCalculator.power(of: m - 1, to: n - 1 - k)) % mod

        // The final result is the product of these independent choices.
        return (waysToChoosePositions * waysToChooseValues) % mod
    }
}

/// A helper struct to encapsulate combinatorial logic and precomputed data.
struct CombinatoricsCalculator {
    var factorials: [Int] = []
    var inverseFactorials: [Int] = []
    private let mod = 1_000_000_007

    init() {
        let maxSize = 100_000
        var computedFactorials = [Int](repeating: 1, count: maxSize)
        var computedInverseFactorials = [Int](repeating: 1, count: maxSize)
        
        // Precompute factorials: fact[i] = i!
        for i in 1..<maxSize {
            computedFactorials[i] = (computedFactorials[i - 1] * i) % mod
        }
        
        // Precompute inverse factorials using Fermat's Little Theorem.
        computedInverseFactorials[maxSize - 1] = power(of: computedFactorials[maxSize - 1], to: mod - 2)
        for i in stride(from: maxSize - 2, through: 0, by: -1) {
            computedInverseFactorials[i] = (computedInverseFactorials[i + 1] * (i + 1)) % mod
        }
        
        self.factorials = computedFactorials
        self.inverseFactorials = computedInverseFactorials
    }
    
    /// Calculates (base^exponent) % mod using modular exponentiation.
    func power(of base: Int, to exponent: Int) -> Int {
        var result = 1
        var b = base % mod
        var e = exponent
        while e > 0 {
            if e % 2 == 1 { result = (result * b) % mod }
            b = (b * b) % mod
            e /= 2
        }
        return result
    }

    /// Calculates combinations C(n, k) using precomputed tables.
    func combinations(_ n: Int, _ k: Int) -> Int {
        if k < 0 || k > n { return 0 }
        let numerator = factorials[n]
        let denominator = (inverseFactorials[k] * inverseFactorials[n - k]) % mod
        return (numerator * denominator) % mod
    }
}
