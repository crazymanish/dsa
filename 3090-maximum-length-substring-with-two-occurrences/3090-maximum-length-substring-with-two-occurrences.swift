/**
 Problem Summary:
 Find the length of the longest substring where each character appears at most twice.

 Strategy:
 Use a sliding window with two pointers. Expand the window with `right`.
 If adding the current character would create a third occurrence, move `left`
 forward until the window becomes valid again.

 Time Complexity: O(n)
 Space Complexity: O(n)
 */
class Solution {
    func maximumLengthSubstring(_ s: String) -> Int {
        var characterFrequency: [Character: Int] = [:]
        var longestLength = 0
        var windowStart = s.startIndex

        for windowEnd in s.indices {
            let currentCharacter = s[windowEnd]

            // Remove characters from the left while the current character
            // already appears twice in the current window.
            while characterFrequency[currentCharacter] == 2 {
                let leftCharacter = s[windowStart]
                characterFrequency[leftCharacter, default: 0] -= 1
                windowStart = s.index(after: windowStart)
            }

            // Add the current character to the sliding window.
            characterFrequency[currentCharacter, default: 0] += 1

            // Calculate the length of the current valid window.
            let currentLength = s.distance(from: windowStart, to: windowEnd) + 1
            longestLength = max(longestLength, currentLength)
        }

        return longestLength
    }
}