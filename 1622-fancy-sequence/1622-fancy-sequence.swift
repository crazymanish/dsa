/**
 Fancy Sequence

 Problem Summary:
 Design a sequence that supports the following operations efficiently:
 - append(val): Append a value to the sequence.
 - addAll(inc): Add `inc` to every element in the sequence.
 - multAll(m): Multiply every element in the sequence by `m`.
 - getIndex(idx): Return the value at index `idx`.

 All results must be returned modulo 1_000_000_007.

 Strategy:
 Instead of updating every element during `addAll` or `multAll`, we keep track of
 two global transformations:

    currentValue = originalValue * globalMultiplier + globalAddition

 When we append a value, we store a **normalized value** that removes the current
 transformation so future operations can still be applied lazily.

 To reverse the multiplier during normalization we compute a **modular inverse**
 using Fermat's Little Theorem.

 This allows all operations to run in O(1) time.

 Time Complexity:
 - append: O(log MOD) due to modular inverse
 - addAll: O(1)
 - multAll: O(1)
 - getIndex: O(1)

 Space Complexity:
 - O(n) for storing the sequence
 */

class Fancy {
    /// Stored normalized values
    private var sequence: [Int] = []

    /// Global multiplier applied lazily to all values
    private var globalMultiplier: Int = 1

    /// Global addition applied lazily to all values
    private var globalAddition: Int = 0

    /// Modulo constant
    private let mod = 1_000_000_007

    // MARK: - Modular Arithmetic Helpers

    /// Fast modular exponentiation (binary exponentiation)
    /// Computes (base^exp) % mod
    private func modPow(_ base: Int, _ exponent: Int) -> Int {
        var result = 1
        var baseValue = base % mod
        var power = exponent

        while power > 0 {
            if power % 2 == 1 {
                result = result * baseValue % mod
            }

            baseValue = baseValue * baseValue % mod
            power /= 2
        }

        return result
    }

    /// Computes modular inverse using Fermat's Little Theorem:
    /// x^(-1) ≡ x^(mod-2) (mod mod)
    private func modInverse(_ value: Int) -> Int {
        return modPow(value, mod - 2)
    }

    init() {}

    // MARK: - Operations

    /// Appends a value into the sequence
    /// We normalize it so future global transformations can still apply lazily
    func append(_ value: Int) {

        /*
         Reverse the current transformation:

         value = normalized * globalMultiplier + globalAddition

         normalized =
            (value - globalAddition) * inverse(globalMultiplier)
        */

        let normalizedValue =
            ((value - globalAddition + mod) % mod) *
            modInverse(globalMultiplier) % mod

        sequence.append(normalizedValue)
    }

    /// Adds `increment` to all elements lazily
    func addAll(_ increment: Int) {
        globalAddition = (globalAddition + increment) % mod
    }

    /// Multiplies all elements lazily
    func multAll(_ multiplier: Int) {
        globalMultiplier = globalMultiplier * multiplier % mod
        globalAddition = globalAddition * multiplier % mod
    }

    /// Returns the value at index `idx`
    func getIndex(_ idx: Int) -> Int {
        guard idx < sequence.count else { return -1 }

        return (sequence[idx] * globalMultiplier % mod + globalAddition) % mod
    }
}

/**
 * Your Fancy object will be instantiated and called as such:
 * let obj = Fancy()
 * obj.append(val)
 * obj.addAll(inc)
 * obj.multAll(m)
 * let ret_4: Int = obj.getIndex(idx)
 */