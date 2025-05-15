// Time Complexity: O(n), where n is the number of words (which is the same as the number of groups).
// The code iterates through the groups array once.

// Space Complexity: O(k), where k is the length of the longest subsequence.
// In the worst case, if all adjacent groups are different, k can be equal to n, resulting in O(n) space.
// The space is used to store the `longestSubsequence` array.
class Solution {
    func getLongestSubsequence(_ words: [String], _ groups: [Int]) -> [String] {
        var longestSubsequence: [String] = [words[0]] // Initialize the result with the first word

        // Iterate through the groups starting from the second element
        for i in 1..<groups.count {
            // If the current group is different from the previous group
            if groups[i] != groups[i - 1] {
                // Append the corresponding word to the longest subsequence
                longestSubsequence.append(words[i])
            }
        }

        return longestSubsequence // Return the longest subsequence of words with alternating groups
    }
}