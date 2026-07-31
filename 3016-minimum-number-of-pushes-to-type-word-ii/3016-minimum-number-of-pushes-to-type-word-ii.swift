/**
 Problem Summary:
 Assign each distinct character to one of eight keypad keys to minimize
 the total number of key presses.

 Strategy:
 Count character frequencies, then assign the most frequent characters to
 the lowest press counts first. Each group of eight characters shares the
 same press count.

 Time Complexity:
 O(n + d log d), where n is the word length and d is the number of
 distinct characters.

 Space Complexity:
 O(d)
 */
class Solution {
    func minimumPushes(_ word: String) -> Int {
        let keysPerPressCount = 8
        var characterFrequency: [Character: Int] = [:]

        // Count how often each character appears.
        for character in word {
            characterFrequency[character, default: 0] += 1
        }

        // Frequent characters should receive fewer required presses.
        let sortedFrequencies = characterFrequency.values.sorted(by: >)

        var totalPushes = 0
        var pressCount = 1

        for (index, frequency) in sortedFrequencies.enumerated() {
            // Every eight characters use the same press count.
            totalPushes += frequency * pressCount

            if (index + 1) % keysPerPressCount == 0 {
                pressCount += 1
            }
        }

        return totalPushes
    }
}