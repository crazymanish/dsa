// Time Complexity: O(1)
// The input `n` is constrained to `1 <= n <= 10^9`, which means it has at most 10 digits.
// - Calculating the sorted hash of `n` involves converting to a string (O(log10 n)), sorting
//   the digits (O(log10 n * log(log10 n))), and hashing. Since log10(n) is at most 10, this is constant time.
// - The loop runs a fixed number of times (31 iterations).
// - Inside the loop, the same constant-time operations are performed for each power of two.
// Therefore, the entire operation takes a constant amount of time regardless of the specific value of `n`.
//
// Space Complexity: O(1)
// The space required to store the sorted string of digits is proportional to the number of
// digits in `n`, which is at most 10. This does not scale and is considered constant space.
class Solution {
    /**
     * Checks if the digits of `n` can be reordered to form a power of two.
     *
     * - Parameter n: The integer to check.
     * - Returns: `true` if a reordering is possible, otherwise `false`.
     */
    func reorderedPowerOf2(_ n: Int) -> Bool {
        // The core idea is to create a "digit signature" for the input number `n`.
        // By sorting the digits, we get a canonical representation. For example,
        // 128, 182, 218, 281, 812, and 821 all have the same sorted digit string "128".
        // We use the hash of this sorted representation for quick comparison.
        let nSortedHash = String(n).sorted().hashValue
        
        // We only need to check against powers of two that could have the same
        // number of digits as `n`. The largest possible `n` is 10^9 (10 digits).
        // The power 2^29 is a 9-digit number, and 2^30 is a 10-digit number.
        // Any higher power of two will have more than 10 digits.
        // So, we only need to check exponents from 0 to 30.
        for exp in 0...30 {
            // For each power of two, create the same "digit signature".
            let powerOf2SortedHash = String(1 << exp).sorted().hashValue
            
            // If the signature of `n` matches the signature of a power of two,
            // it means they are composed of the exact same digits.
            if nSortedHash == powerOf2SortedHash {
                return true
            }
        }
        
        // If the loop completes without finding a match, no such reordering is possible.
        return false
    }
}