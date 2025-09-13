// Time Complexity: O(N)
//   - N: The length of the input string `s`.
//   - The algorithm iterates through the string once to build the frequency maps.
//     This takes O(N) time.
//   - Finding the maximum value in the frequency dictionaries takes time proportional
//     to the number of unique characters (at most 26), which is a constant.
//   - Therefore, the overall time complexity is linear with respect to the string length.
//
// Space Complexity: O(A) or O(1)
//   - A: The size of the character alphabet (e.g., 26 for lowercase English letters).
//   - The space is used for the two dictionaries, which store at most `A` unique keys.
//   - This is considered constant space as it does not scale with the length of the input string `N`.
class Solution {
    /**
     * Calculates the sum of the frequency of the most frequent vowel and the most frequent consonant in a string.
     *
     * The strategy is a two-step process:
     * 1.  **Frequency Counting:** Iterate through the string once, populating two separate
     * frequency maps (dictionaries): one for vowels and one for consonants.
     * 2.  **Find Maximums and Sum:** Find the highest frequency value from each of the two maps.
     * The final result is the sum of these two maximum frequencies.
     *
     * - Parameter s: The input string, containing lowercase English letters.
     * - Returns: The sum of the max vowel frequency and the max consonant frequency.
     */
    func maxFreqSum(_ s: String) -> Int {
        // --- Step 1: Count Frequencies of Vowels and Consonants ---
        
        // Dictionaries to store the counts of each character.
        var vowelFrequencies: [Character: Int] = [:]
        var consonantFrequencies: [Character: Int] = [:]
        
        // A set for O(1) lookup to identify vowels.
        let vowels: Set<Character> = ["a", "e", "i", "o", "u"]

        // Iterate through each character to populate the frequency maps.
        for char in s {
            if vowels.contains(char) {
                vowelFrequencies[char, default: 0] += 1
            } else {
                consonantFrequencies[char, default: 0] += 1
            }
        }

        // --- Step 2: Find the Maximum Frequency in Each Group ---

        // Find the highest frequency among all vowels.
        // Use `?? 0` to handle the case where the string has no vowels.
        let maxVowelFrequency = vowelFrequencies.values.max() ?? 0
        
        // Find the highest frequency among all consonants.
        // Use `?? 0` to handle the case where the string has no consonants.
        let maxConsonantFrequency = consonantFrequencies.values.max() ?? 0

        // The result is the sum of the two maximums.
        return maxVowelFrequency + maxConsonantFrequency
    }
}