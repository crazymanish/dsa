// Time Complexity: O(log k)
// The algorithm's runtime is proportional to the number of bits in `k`.
// In each loop, `k` is reduced by a power of two, effectively halving it,
// which leads to logarithmic time complexity.

// Space Complexity: O(1)
// The function uses a fixed number of variables, requiring constant space
// regardless of the input size `k`.

class Solution {
    /**
     * Finds the k-th character in a recursively defined sequence where transformations
     * at each level of recursion are determined by the `operations` array.
     *
     * - Parameters:
     * - k: The 1-based index of the character to find.
     * - operations: An array where `operations[n] == 1` indicates a transformation
     * should occur at level `n`.
     * - Returns: The calculated character.
     */
    func kthCharacter(_ k: Int, _ operations: [Int]) -> Character {
        var currentIndex = k
        var incrementCount = 0

        // We work backwards from `k`. In each step, we find the largest power of two
        // smaller than `currentIndex`, which corresponds to a level `n`. We check if
        // an operation exists for that level and then reduce `currentIndex` to its
        // equivalent position in the previous, smaller sequence block.
        while currentIndex > 1 {
            // The 0-based index simplifies finding the block size.
            let zeroBasedIndex = currentIndex - 1

            // Find the level `n` (as in 2^n). This is equivalent to floor(log2(index)).
            // We use fast bitwise operations instead of floating-point math.
            let level = zeroBasedIndex.bitWidth - zeroBasedIndex.leadingZeroBitCount - 1

            // Reduce the index by 2^n to find its counterpart in the previous block.
            currentIndex -= (1 << level)

            // Check if a transformation (increment) should be applied for this level.
            // A bounds check ensures we don't crash if `level` is out of range.
            if level < operations.count && operations[level] == 1 {
                incrementCount += 1
            }
        }

        // The final character is 'a' plus the total increments, wrapped around the 26 letters.
        let finalValue = incrementCount % 26
        
        // Convert the final numeric value (0-25) to its ASCII representation ('a'-'z').
        return Character(UnicodeScalar(finalValue + 97)!)
    }
}