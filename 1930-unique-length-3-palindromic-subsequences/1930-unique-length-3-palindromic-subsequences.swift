/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • Let n = s.count, and d = number of distinct characters in s.
///   • Building first/last maps:      O(n)
///   • For each distinct character:
///       - Collecting middle characters into a Set: O(length of segment)
///   • Overall: O(n * d), which is effectively O(n) if the alphabet is small
///     (e.g., lowercase English letters).
///
/// Space Complexity:
///   • O(d) for the first/last occurrence maps
///   • O(min(n, d)) for the temporary middle-character Set
///   • Overall: O(d), typically O(1) for fixed-size alphabets.
///
/// Description:
///   For each distinct character `c`, we:
///   1. Find its first and last positions in the string.
///   2. Look at all characters strictly between those two positions.
///   3. The number of distinct middle characters gives the number of
///      palindromic subsequences of the form c ? c (length 3).
///   Summing this over all distinct characters gives the final answer.
/// ---------------------------------------------------------------------------

class Solution {
    func countPalindromicSubsequence(_ s: String) -> Int {
        let characters = Array(s)

        // Track first and last occurrence of each character
        var firstOccurrence: [Character: Int] = [:]
        var lastOccurrence: [Character: Int] = [:]

        for (index, ch) in characters.enumerated() {
            // Set first occurrence only if it doesn't exist yet
            if firstOccurrence[ch] == nil {
                firstOccurrence[ch] = index
            }
            // Update last occurrence every time
            lastOccurrence[ch] = index
        }

        var result = 0

        // For each distinct character, count unique middle characters
        for (ch, leftIndex) in firstOccurrence {
            if let rightIndex = lastOccurrence[ch], rightIndex > leftIndex {
                // Characters strictly between the first and last occurrence
                let middleCharacters = Set(characters[(leftIndex + 1)..<rightIndex])
                result += middleCharacters.count
            }
        }

        return result
    }
}
