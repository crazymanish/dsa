// Time Complexity: O(N * L)
// Space Complexity: O(K)
class Solution {
    func findWordsContaining(_ words: [String], _ x: Character) -> [Int] {
        var wordIndicesContainingX: [Int] = [] // Initialize an array to store the indices of words containing 'x'

        // Iterate through the input 'words' array along with their indices
        // The loop runs 'N' times, where N is the number of words.
        for (currentIndex, currentWord) in words.enumerated() {
            // Check if the current word contains the character 'x'.
            // The `String.contains(Character)` method takes O(L) time in the worst case,
            // where L is the length of `currentWord`.
            if currentWord.contains(x) {
                // If the word contains 'x', add its index to the result array.
                // Appending to an array takes O(1) on average.
                wordIndicesContainingX.append(currentIndex)
            }
        }

        return wordIndicesContainingX // Return the list of indices
    }
}