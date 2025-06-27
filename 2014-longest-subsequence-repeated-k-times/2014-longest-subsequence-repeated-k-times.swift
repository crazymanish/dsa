// Time Complexity: O(n + m^L * (n*k))
// This remains the same as the underlying algorithm is similar, dominated by generating
// and checking candidate subsequences level by level.

// Space Complexity: O(m^L + n)
// This also remains the same, dominated by storing the candidates for each level.

class Solution {
    /**
     * Finds the longest subsequence of `s` that is repeated `k` times.
     * If multiple subsequences have the same max length, it returns the lexicographically largest one.
     */
    func longestSubsequenceRepeatedK(_ s: String, _ k: Int) -> String {
        // --- Step 1: Find all candidate characters, sorted descending. ---
        // Sorting descending helps generate lexicographically larger candidates first.
        let candidateChars = "abcdefghijklmnopqrstuvwxyz".reversed().filter { char in
            s.lazy.filter { $0 == char }.count >= k
        }
        
        var longestSubsequence = ""
        var currentLevel = [""] // Start with an empty string to build from.

        // --- Step 2: Build and check subsequences level by level ---
        while true {
            var nextLevel: [String] = []
            
            // From each valid subsequence of the current length...
            for parent in currentLevel {
                // ...try appending every possible candidate character.
                for char in candidateChars {
                    let child = parent + String(char)
                    if isSubsequence(of: child, repeated: k, in: s) {
                        nextLevel.append(child)
                    }
                }
            }

            // If we couldn't form any longer valid subsequences, we are done.
            if nextLevel.isEmpty {
                break
            }
            
            // The new best answer is the lexicographically largest one from the new level.
            longestSubsequence = nextLevel.max() ?? longestSubsequence
            currentLevel = nextLevel
        }
        
        return longestSubsequence
    }
    
    /// Checks if a `subsequence`, when repeated `k` times, is a subsequence of the main `text`.
    private func isSubsequence(of subsequence: String, repeated k: Int, in text: String) -> Bool {
        if subsequence.isEmpty { return true }
        
        let textChars = Array(text)
        let subChars = Array(subsequence)
        var textIndex = 0 // The current position in the main text

        // We need to find the subsequence `k` times.
        for _ in 0..<k {
            // For each repetition, find every character of the subsequence in order.
            for subChar in subChars {
                // Find the next occurrence of `subChar` in `text` starting from `textIndex`.
                if let nextMatchIndex = textChars[textIndex...].firstIndex(of: subChar) {
                    // Start the next search from the position *after* the found character.
                    textIndex = nextMatchIndex + 1
                } else {
                    // If a character can't be found, the subsequence check fails.
                    return false
                }
            }
        }
        
        // If we successfully found all characters for all `k` repetitions, succeed.
        return true
    }
}