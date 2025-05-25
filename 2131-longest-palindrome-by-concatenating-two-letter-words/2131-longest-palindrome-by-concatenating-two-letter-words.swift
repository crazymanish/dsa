// Time Complexity: O(N * L + C^2) ~ O(N + C^2) given L is constant (2)
// Space Complexity: O(C^2)
class Solution {
    func longestPalindrome(_ words: [String]) -> Int {
        // `charPairCounts[i][j]` stores the count of word "ij" (where i and j are 0-25 representing 'a'-'z')
        // Space: O(C^2) where C is the size of the alphabet (26). This is O(1) as C is constant.
        var charPairCounts = Array(repeating: Array(repeating: 0, count: 26), count: 26)
        var totalPalindromeLength = 0 // Stores the total length of the longest palindrome

        // First pass: Count pairs and form palindromes
        // Time: O(N * L), where N is the number of words, and L is the length of each word (L=2 here).
        // So, effectively O(N) because word length is constant.
        for wordString in words {
            let characters = Array(wordString)
            // Convert characters to 0-indexed integers (0 for 'a', 1 for 'b', etc.)
            let firstCharIndex = Int(characters[0].asciiValue! - Character("a").asciiValue!)
            let secondCharIndex = Int(characters[1].asciiValue! - Character("a").asciiValue!)

            // Check if we have seen the reverse of the current word (e.g., if current is "ab", check for "ba")
            // This is an O(1) lookup in the 2D array.
            if charPairCounts[secondCharIndex][firstCharIndex] > 0 {
                // If "ba" exists, we can form "abba" (length 4) by using "ab" and "ba"
                totalPalindromeLength += 4
                charPairCounts[secondCharIndex][firstCharIndex] -= 1 // Decrement count of "ba" (O(1))
            } else {
                // If "ba" doesn't exist, increment count of "ab" (O(1))
                charPairCounts[firstCharIndex][secondCharIndex] += 1
            }
        }

        // Second pass: Check for a central palindrome word (e.g., "aa", "bb")
        // We can use one such word (if available) in the very center of the palindrome.
        // Time: O(C), where C is the size of the alphabet (26). This is O(1) as C is constant.
        for charIndex in 0..<26 {
            // If there's an unused word like "aa", "bb", etc. (diagonal elements in the matrix)
            // This is an O(1) lookup.
            if charPairCounts[charIndex][charIndex] > 0 {
                totalPalindromeLength += 2 // Add its length (2) to the total
                break // We only need one such central word, so break after finding the first one
            }
        }

        return totalPalindromeLength // Return the total length of the longest palindrome
    }
}