/**
 Problem Summary:
 Given a palindromic string, rearrange its characters to form the
 lexicographically smallest possible palindrome.

 Strategy:
 Count the characters in the left half of the palindrome.
 Place those characters in ascending order on both sides.
 The middle character, if present, remains unchanged.

 Time Complexity: O(n + k log k)
 Space Complexity: O(n + k)
 where k is the number of distinct characters.
 */
class Solution {
    func smallestPalindrome(_ input: String) -> String {
        let characters = Array(input)
        let length = characters.count
        let halfLength = length / 2

        var leftHalfFrequency: [Character: Int] = [:]

        // Count the characters that can be rearranged in the left half.
        for index in 0..<halfLength {
            leftHalfFrequency[characters[index], default: 0] += 1
        }

        var palindrome = characters
        var leftIndex = 0

        // Place smaller characters first to obtain the lexicographically
        // smallest palindrome.
        for character in leftHalfFrequency.keys.sorted() {
            let occurrences = leftHalfFrequency[character, default: 0]

            for _ in 0..<occurrences {
                palindrome[leftIndex] = character
                palindrome[length - leftIndex - 1] = character
                leftIndex += 1
            }
        }

        return String(palindrome)
    }
}