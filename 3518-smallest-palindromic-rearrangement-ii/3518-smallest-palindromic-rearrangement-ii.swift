/**
 Problem Summary:
 Construct the k-th lexicographically smallest palindromic permutation of `s`.

 Strategy:
 - Count the characters used in the left half of the palindrome.
 - Build the left half greedily from smallest to largest character.
 - For each candidate character, count how many distinct permutations
   can be formed with the remaining characters.
 - Skip candidates whose permutation groups appear before rank `k`.
 - Mirror the left half and include the middle character when needed.

 Time Complexity:
 O(n × 26 × 26 × 26), where `n` is the length of `s`.
 In practice, the alphabet size is constant, so this is effectively O(n).

 Space Complexity:
 O(n), used for the character array and the resulting palindrome.
 */
class Solution {
    func smallestPalindrome(_ s: String, _ k: Int) -> String {
        let characters = Array(s)
        let halfLength = characters.count / 2

        // Count character frequencies for the left half.
        var halfFrequencies = Array(repeating: 0, count: 26)

        for index in 0..<halfLength {
            guard let asciiValue = characters[index].asciiValue else {
                continue
            }

            halfFrequencies[Int(asciiValue) - Character.asciiOffset] += 1
        }

        var leftHalf = ""
        var skippedPermutations = 0

        // Build the left half greedily in lexicographical order.
        for position in 0..<halfLength {
            for characterIndex in 0..<26 {
                guard halfFrequencies[characterIndex] > 0 else {
                    continue
                }

                // Temporarily use this character.
                halfFrequencies[characterIndex] -= 1

                let remainingLength = halfLength - position - 1
                let candidatePermutations = countPermutations(
                    remainingLength,
                    halfFrequencies,
                    k
                )

                // If this group contains the desired rank, keep the character.
                if skippedPermutations + candidatePermutations >= k {
                    let scalar = UnicodeScalar(
                        Character.asciiOffset + characterIndex
                    )!

                    leftHalf.append(Character(scalar))
                    break
                }

                // Otherwise, skip this entire group and restore the frequency.
                halfFrequencies[characterIndex] += 1
                skippedPermutations += candidatePermutations
            }
        }

        // Not enough permutations exist for the requested rank.
        guard leftHalf.count == halfLength else {
            return ""
        }

        // Mirror the left half to complete the palindrome.
        var result = leftHalf

        if characters.count % 2 == 1 {
            result.append(characters[halfLength])
        }

        result += String(leftHalf.reversed())
        return result
    }

    /// Returns `min(C(n, m), k + 1)` to avoid unnecessary large calculations.
    private func combinations(_ n: Int, _ m: Int, limit k: Int) -> Int {
        let selectedCount = min(m, n - m)

        guard selectedCount > 0 else {
            return 1
        }

        var result = 1

        for index in 1...selectedCount {
            result = result * (n - index + 1) / index

            if result > k {
                return k + 1
            }
        }

        return result
    }

    /// Counts distinct permutations represented by the remaining frequencies.
    private func countPermutations(
        _ remainingLength: Int,
        _ frequencies: [Int],
        _ limit: Int
    ) -> Int {
        var remainingSlots = remainingLength
        var permutationCount = 1

        // Multinomial counting:
        // C(slots, count) is applied for each character group.
        for frequency in frequencies where frequency > 0 {
            permutationCount *= combinations(
                remainingSlots,
                frequency,
                limit: limit
            )

            if permutationCount > limit {
                return limit + 1
            }

            remainingSlots -= frequency
        }

        return permutationCount
    }
}

private extension Character {
    static let asciiOffset = 97 // ASCII value of lowercase "a"
}