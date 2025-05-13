class Solution {
    let MOD = Int(1e9 + 7) // Constant for modulo operations

    /**
     Calculates the total "length" (sum of counts of all character types)
     after applying a specific transformation rule 't' times.

     - Parameters:
        - s: The initial string of lowercase English letters.
        - t: The number of transformation steps to perform.
     - Returns: The total sum of character counts modulo MOD after 't' transformations.

     Complexity:
        - Time: O(L + t), where L is the length of string 's' and 't' is the number of transformations.
                - O(L) for initial character counting.
                - O(t) for the transformation loop.
                - O(A) (alphabet size, constant) for array initialization and final reduction, absorbed into O(L+t).
        - Space: O(A) or O(1) auxiliary space (for `charCounts` array, where A=26 is constant).
                 Input string 's' takes O(L) space.
    */
    func lengthAfterTransformations(_ s: String, _ t: Int) -> Int {
        // Initialize character counts array for 'a' through 'z'
        // Time: O(A), Space: O(A) where A=26
        var charCounts = [Int](repeating: 0, count: 26)

        // Populate initial counts from the input string 's'
        // Time: O(L), where L is length of s
        for charValue in s { // Using `charValue` to avoid conflict if `c` is used elsewhere conceptually
            if let ascii = charValue.asciiValue {
                let charIndex = Int(ascii - Character("a").asciiValue!) // 'a' = 0, 'b' = 1, ...
                if charIndex >= 0 && charIndex < 26 { // Basic validation for lowercase English letters
                    charCounts[charIndex] = (charCounts[charIndex] + 1) // No MOD needed here for initial counts if L < MOD
                }
            }
        }

        // currentZIdx represents the index of the character whose count will be used as a source
        // for the transformation. It starts at 'z' (25) and moves backward cyclically.
        var sourceCharIndex = 25 // Start with 'z'

        // Perform 't' transformation steps
        // Time: O(t)
        for _ in 0..<t {
            // targetCharIndex is (sourceCharIndex + 1) % 26
            // e.g., if source is 'z' (25), target is 'a' (0)
            // e.g., if source is 'a' (0), target is 'b' (1)
            let targetCharIndex = (sourceCharIndex + 1) % 26

            // Add the count of sourceCharIndex's characters to targetCharIndex's characters
            charCounts[targetCharIndex] = (charCounts[targetCharIndex] + charCounts[sourceCharIndex]) % MOD

            // Move sourceCharIndex to the previous character (cyclically)
            // e.g., 'z' (25) -> 'y' (24), ..., 'a' (0) -> 'z' (25)
            sourceCharIndex = (sourceCharIndex - 1 + 26) % 26
        }

        // Calculate the sum of all character counts, modulo MOD
        // Time: O(A)
        var totalLength = 0
        for count in charCounts {
            totalLength = (totalLength + count) % MOD
        }
        // Or using reduce: charCounts.reduce(0) { ($0 + $1) % MOD }
        // The provided `charCounts.reduce(0, +) % MOD` is also correct and common.
        // My loop above does modulo at each addition step in reduce, which is safer for very large A,
        // but for A=26, `reduce(0,+)` sum won't overflow standard Int before the final MOD.

        return totalLength
    }
}