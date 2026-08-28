class Solution {
    /**
     Problem Summary:
     Given a string `s`, rearrange its characters to form the lexicographically
     smallest palindromic permutation that is strictly greater than `target`.
     Return an empty string if no such palindrome exists.

     Strategy:
     1. Count the frequency of each lowercase English letter.
     2. Verify that the characters can form a palindrome:
        - At most one character may have an odd frequency.
     3. Since a palindrome is completely determined by its left half and
        optional middle character, store half of each character's frequency.
     4. Build the left half greedily from left to right:
        - Try available characters from smallest to largest.
        - Temporarily choose a character.
        - Complete the remaining left half using the largest possible characters.
        - Construct the corresponding largest palindrome for this prefix.
        - Keep the choice only if that palindrome can still be greater than `target`.
     5. Mirror the completed left half to construct the final palindrome.

     Time Complexity:
     O(n²), because each greedy position may construct and compare a palindrome
     containing O(n) characters.

     Space Complexity:
     O(n), primarily for the prefix and temporary palindrome construction.
     */
    func lexPalindromicPermutation(_ s: String, _ target: String) -> String {
        let characters = Array(s)
        let length = characters.count

        // Count the frequency of every lowercase English letter.
        var characterCounts = Array(repeating: 0, count: 26)

        for character in characters {
            let characterIndex = Int(character.asciiValue! - 97)
            characterCounts[characterIndex] += 1
        }

        // A palindrome can contain at most one character with an odd frequency.
        var middleCharacter: Character = "\0"
        var oddFrequencyCount = 0

        for characterIndex in 0..<26 {
            if characterCounts[characterIndex] % 2 == 1 {
                oddFrequencyCount += 1
                middleCharacter = character(for: characterIndex)
            }
        }

        guard oddFrequencyCount <= 1 else {
            return ""
        }

        // Only half of each frequency is needed to construct the left half.
        // The right half will simply be its reverse.
        var remainingHalfCounts = Array(repeating: 0, count: 26)

        for characterIndex in 0..<26 {
            remainingHalfCounts[characterIndex] =
                characterCounts[characterIndex] / 2
        }

        let halfLength = length / 2
        var leftHalf: [Character] = []

        // Checks whether the current left-half prefix can still produce
        // a palindrome that is strictly greater than `target`.
        func canProduceGreaterPalindrome() -> Bool {
            var largestPossibleLeftHalf = leftHalf

            // To maximize the palindrome for the current prefix, place all
            // remaining characters in descending lexicographical order.
            for characterIndex in stride(from: 25, through: 0, by: -1) {
                for _ in 0..<remainingHalfCounts[characterIndex] {
                    largestPossibleLeftHalf.append(
                        character(for: characterIndex)
                    )
                }
            }

            var largestPossiblePalindrome = largestPossibleLeftHalf

            if length % 2 == 1 {
                largestPossiblePalindrome.append(middleCharacter)
            }

            largestPossiblePalindrome.append(
                contentsOf: largestPossibleLeftHalf.reversed()
            )

            return String(largestPossiblePalindrome) > target
        }

        // Greedily construct the lexicographically smallest valid left half.
        for _ in 0..<halfLength {
            var validCharacterFound = false

            // Trying characters from smallest to largest guarantees that
            // the first feasible choice gives the smallest possible answer.
            for characterIndex in 0..<26 {
                guard remainingHalfCounts[characterIndex] > 0 else {
                    continue
                }

                remainingHalfCounts[characterIndex] -= 1
                leftHalf.append(character(for: characterIndex))

                // Keep this character only if some completion of this prefix
                // can still produce a palindrome greater than `target`.
                if canProduceGreaterPalindrome() {
                    validCharacterFound = true
                    break
                }

                // This choice cannot lead to an answer, so backtrack.
                leftHalf.removeLast()
                remainingHalfCounts[characterIndex] += 1
            }

            guard validCharacterFound else {
                return ""
            }
        }

        // The completed palindrome is determined entirely by its left half.
        var palindrome = leftHalf

        if length % 2 == 1 {
            palindrome.append(middleCharacter)
        }

        palindrome.append(contentsOf: leftHalf.reversed())

        let result = String(palindrome)

        return result > target ? result : ""
    }

    /// Converts a zero-based alphabet index into its lowercase character.
    private func character(for index: Int) -> Character {
        Character(UnicodeScalar(97 + index)!)
    }
}