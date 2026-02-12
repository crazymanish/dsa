class Solution {

    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(n²)
    ///     - For each starting index, we expand the substring.
    ///     - Each expansion step is O(1).
    ///
    /// Space Complexity:
    ///   • O(26) = O(1)
    ///     - Fixed-size frequency array for lowercase letters.
    ///
    /// Problem Summary:
    ///   Find the length of the longest substring where
    ///   all appearing characters have the same frequency.
    ///
    /// Optimization Insight:
    ///   Instead of checking all 26 frequencies every time,
    ///   we maintain:
    ///     - distinctCount → number of unique characters in window
    ///     - maxFrequency  → maximum frequency among them
    ///
    ///   A substring is balanced if:
    ///       length == distinctCount * maxFrequency
    /// -----------------------------------------------------------------------
    func longestBalanced(_ s: String) -> Int {
        let characters = Array(s)
        let totalLength = characters.count
        
        var longestValidLength = 0
        
        // Fix the starting index of the substring
        for startIndex in 0..<totalLength {
            
            // Frequency of each character in the current substring
            var frequency = Array(repeating: 0, count: 26)
            
            var distinctCount = 0      // number of distinct characters
            var maxFrequency = 0       // highest frequency seen so far
            
            // Expand the substring to the right
            for endIndex in startIndex..<totalLength {
                
                // Convert character to 0...25 index
                let charIndex =
                    Int(characters[endIndex].asciiValue! -
                        Character("a").asciiValue!)
                
                // If this character appears for the first time
                if frequency[charIndex] == 0 {
                    distinctCount += 1
                }
                
                // Update frequency
                frequency[charIndex] += 1
                
                // Track maximum frequency dynamically
                maxFrequency = max(maxFrequency, frequency[charIndex])
                
                let currentLength = endIndex - startIndex + 1
                
                // Balanced condition:
                // All characters must have the same frequency.
                // That means:
                //   total length == distinct characters × frequency
                if currentLength == distinctCount * maxFrequency {
                    longestValidLength =
                        max(longestValidLength, currentLength)
                }
            }
        }
        
        return longestValidLength
    }
}
