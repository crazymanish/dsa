/*
Time Complexity: O(n)
We iterate through the string of length n exactly once. All operations inside the loop (character property checks, set lookups) are constant time.

Space Complexity: O(1)
The space used is constant because we iterate directly over the input string without creating a copy. The vowels set is of a fixed size.
*/
class Solution {
    func isValid(_ word: String) -> Bool {
        // 1. Check if the word meets the minimum length requirement.
        guard word.count >= 3 else { return false }

        // A set for efficient O(1) vowel lookups.
        let vowels: Set<Character> = ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]
        var hasVowel = false
        var hasConsonant = false

        // 2. Iterate through each character to validate the word's content.
        for character in word {
            if character.isLetter {
                // The character is a letter. Check if it's a vowel or consonant.
                if vowels.contains(character) {
                    hasVowel = true
                } else {
                    hasConsonant = true
                }
            } else if character.isNumber {
                // Numbers are allowed, so we just continue.
                continue
            } else {
                // The character is not a letter or a number (e.g., '@', '#', '$').
                // The word is invalid.
                return false
            }
        }

        // 3. The word is valid only if it contains both a vowel and a consonant.
        return hasVowel && hasConsonant
    }
}