// Time Complexity: O(N + Σ^2)
// - Counting character frequencies: O(N), where N is the length of the input word.
// - Extracting unique frequencies: O(Σ), where Σ is the number of unique characters (at most 26 for English alphabet).
// - The nested function `calculateDeletionsForTargetMinFreq` iterates through the unique frequencies (Σ times), taking O(Σ) time.
// - The `map` operation calls `calculateDeletionsForTargetMinFreq` for each unique frequency (Σ times).
//   This results in O(Σ * Σ) = O(Σ^2) for the mapping step.
// - Finding the minimum in the resulting array takes O(Σ) time.
// - Overall, the dominant factor is O(N + Σ^2). Given Σ is a small constant (e.g., 26 for lowercase letters),
//   the complexity effectively becomes O(N).

// Space Complexity: O(Σ)
// - The `characterFrequencies` dictionary stores counts for unique characters, requiring O(Σ) space.
// - The `uniqueFrequencies` array also takes O(Σ) space.
// - The `allPossibleDeletionCounts` array takes O(Σ) space.
// - Overall, the space complexity is proportional to the number of unique characters.

class Solution {
    /// Calculates the minimum number of characters to delete from a word
    /// such that the frequency of every remaining character 'c' satisfies:
    /// `targetMinFrequency <= frequency(c) <= targetMinFrequency + kThreshold`
    /// for some chosen `targetMinFrequency`.
    ///
    /// - Parameters:
    ///   - word: The input string from which characters will be deleted.
    ///   - kThreshold: The maximum allowed difference between the lowest and highest character frequencies
    ///                 in the final, modified word.
    /// - Returns: The minimum total number of deletions required.
    func minimumDeletions(_ word: String, _ kThreshold: Int) -> Int {
        // 1. Count the frequency of each character in the input word.
        var characterFrequencies: [Character: Int] = [:]
        for character in word {
            characterFrequencies[character, default: 0] += 1
        }
        
        // 2. Extract only the frequency values into an array.
        let uniqueFrequencies = Array(characterFrequencies.values)
        
        /// A helper function to calculate the total deletions needed if a specific
        /// `targetMinFrequency` is chosen for the final state of all character frequencies.
        ///
        /// - Parameter targetMinFrequency: The desired minimum frequency for characters in the modified word.
        /// - Returns: The total number of deletions required to satisfy the condition
        ///            `targetMinFrequency <= freq <= targetMinFrequency + kThreshold` for all characters.
        func calculateDeletionsForTargetMinFreq(_ targetMinFrequency: Int) -> Int {
            var totalDeletions = 0
            // Iterate through each unique frequency found in the original word.
            for currentFrequency in uniqueFrequencies {
                // If a character's frequency is less than the target minimum,
                // all occurrences of this character must be deleted.
                if currentFrequency < targetMinFrequency {
                    totalDeletions += currentFrequency
                }
                // If a character's frequency is greater than the allowed upper bound
                // (targetMinFrequency + kThreshold), then the excess occurrences must be deleted.
                if currentFrequency > targetMinFrequency + kThreshold {
                    totalDeletions += currentFrequency - (targetMinFrequency + kThreshold)
                }
                // If currentFrequency is within [targetMinFrequency, targetMinFrequency + kThreshold],
                // no deletions are needed for this character.
            }
            return totalDeletions
        }
        
        // 3. Explore possible target minimum frequencies.
        // We iterate through each unique frequency present in the original word.
        // It's a common strategy in such problems that an optimal `targetMinFrequency`
        // often aligns with one of the existing frequencies.
        // Also consider 0 as a possible targetMinFrequency, meaning we want to delete everything
        // unless it fits within [0, kThreshold].
        let possibleTargetFrequencies = uniqueFrequencies + [0] // Include 0 as a possible target minimum
        
        let allPossibleDeletionCounts = possibleTargetFrequencies.map { targetFreq in
            calculateDeletionsForTargetMinFreq(targetFreq)
        }
        
        // 4. Return the minimum deletions found among all considered possibilities.
        // The '!' is used as `allPossibleDeletionCounts` will never be empty if `word` is not empty.
        // If word is empty, uniqueFrequencies is empty, [0] makes it [0], calculateDeletionsForTargetMinFreq(0) returns 0.
        return allPossibleDeletionCounts.min()!
    }
}