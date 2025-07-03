// Time Complexity: O(1)
// The solution involves a few arithmetic operations and a call to `nonzeroBitCount`,
// which is a hardware-level instruction on modern CPUs. Its execution time is constant
// and does not depend on the size of `k`.

// Space Complexity: O(1)
// The algorithm uses a fixed amount of space regardless of the input `k`.

class Solution {
    /**
     * Finds the k-th character in a recursively defined sequence using a direct calculation.
     * The character's value ('a'=0, 'b'=1, etc.) is the population count (number of set bits)
     * in the binary representation of the 0-based index (k - 1).
     *
     * - Parameter k: The 1-based index of the character to find.
     * - Returns: The k-th character.
     */
    func kthCharacter(_ k: Int) -> Character {
        // The 0-based index is k - 1.
        let zeroBasedIndex = k - 1
        
        // The number of increments from 'a' is the number of set bits (1s)
        // in the binary representation of the index. Swift provides a property for this.
        let increments = zeroBasedIndex.nonzeroBitCount
        
        // The final character value wraps around the 26 letters of the alphabet.
        // 'a' corresponds to 0, 'b' to 1, etc.
        let finalValue = increments % 26
        
        // Convert the final numeric value (0-25) to its corresponding character ('a'-'z').
        // The ASCII value of 'a' is 97.
        return Character(UnicodeScalar(finalValue + 97)!)
    }
}