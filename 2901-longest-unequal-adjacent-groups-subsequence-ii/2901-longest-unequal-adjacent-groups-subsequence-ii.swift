// Time Complexity: O(n^2 * L), where n is the number of words and L is the maximum length of a word.
// - The outer loop in `getWordsInLongestSubsequence` runs n-1 times.
// - The inner loop runs up to i times (O(n) in the worst case).
// - The `hammingDistance` function takes O(L) in the worst case (when words have the same length).
// - Finding the maximum in `dp` takes O(n).
// - Backtracking takes O(n) in the worst case.

// Space Complexity: O(n * L), where n is the number of words and L is the maximum length of a word.
// - `utf8Words` stores n arrays of characters, with a total space complexity proportional to the total length of all words (up to n * L).
// - `dp` array stores n tuples.
// - `longestSubsequence` can store up to n words.
class Solution {
    func getWordsInLongestSubsequence(_ words: [String], _ groups: [Int]) -> [String] {
        let wordCount = words.count // Number of words in the input array
        // Convert words to an array of UTF8 arrays for faster Hamming distance calculation
        let utf8Words = words.map { Array($0.utf8) }
        // dp[i] stores the length of the longest valid subsequence ending with words[i]
        // and the index of the previous word in that subsequence for backtracking
        var dp = [(length: Int, previousIndex: Int)](repeating: (1, -1), count: wordCount)

        // O(n^2 * L) DP simulation, where L is the maximum length of a word (for Hamming distance)
        for i in 1..<wordCount {
            for j in 0..<i {
                // O(L) Hamming distance calculation
                if groups[i] != groups[j] && hammingDistance(i, j, utf8Words) == 1 && dp[i].length <= dp[j].length {
                    dp[i] = (dp[j].length + 1, j)
                }
            }
        }

        // O(n) to find the index of the end of the longest subsequence
        var endIndex = dp.enumerated().max(by: { $0.element.length < $1.element.length })!.offset
        var longestSubsequence = [String]() // Array to store the longest subsequence

        // O(n) backtracking to reconstruct the longest subsequence
        while endIndex != -1 {
            longestSubsequence.append(words[endIndex]) // Add the word at the current index
            endIndex = dp[endIndex].previousIndex // Move to the previous index
        }

        return longestSubsequence.reversed() // Reverse the subsequence to get the correct order
    }

    // O(L) Helper function to calculate the Hamming distance between two words
    private func hammingDistance(_ index1: Int, _ index2: Int, _ utf8Words: [[UInt8]]) -> Int {
        let word1 = utf8Words[index1]
        let word2 = utf8Words[index2]
        
        if word1.count != word2.count { return .max }

        return word1.indices.count { word1[$0] != word2[$0] }
    }
}