/**
 * Problem Summary:
 * Return the maximum number of times the word "balloon" can be formed
 * using the characters from the input string.
 *
 * Strategy:
 * - Count the frequency of each character.
 * - "balloon" requires:
 *   - b: 1
 *   - a: 1
 *   - l: 2
 *   - o: 2
 *   - n: 1
 * - The answer is the minimum available count among these requirements.
 *
 * Time Complexity:
 * O(n)
 *
 * Space Complexity:
 * O(1)
 * - At most a fixed number of character counts are stored.
 */
class Solution {
    func maxNumberOfBalloons(_ text: String) -> Int {
        var characterCount: [Character: Int] = [:]

        // Count occurrences of each character.
        for character in text {
            characterCount[character, default: 0] += 1
        }

        // Determine how many complete "balloon" words can be formed.
        return min(
            characterCount["b", default: 0],
            characterCount["a", default: 0],
            characterCount["l", default: 0] / 2,
            characterCount["o", default: 0] / 2,
            characterCount["n", default: 0]
        )
    }
}