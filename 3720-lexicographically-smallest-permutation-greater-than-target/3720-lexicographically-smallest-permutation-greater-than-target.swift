/**
 Problem Summary:
 Given two strings `s` and `target`, rearrange the characters of `s`
 to find the lexicographically smallest permutation that is strictly
 greater than `target`.

 Strategy:
 - Track the difference between available characters from `s` and
   characters required by `target`.
 - Scan `target` from right to left.
 - At each position, determine whether the prefix before that position
   can be constructed using characters from `s`.
 - Replace the current character with the smallest available character
   that is strictly greater.
 - Append all remaining characters in sorted order to minimize the result.

 Time Complexity:
 O(26 * n), which simplifies to O(n).

 Space Complexity:
 O(n) for character/result storage.
 The frequency array uses O(26) = O(1) space.
 */
class Solution {

    func lexGreaterPermutation(_ s: String, _ target: String) -> String {
        let sourceCharacters = Array(s)
        var targetCharacters = Array(target)

        var frequencyDifference = Array(repeating: 0, count: 26)

        // Build the frequency difference between `s` and `target`.
        for index in sourceCharacters.indices {
            let sourceIndex = Int(sourceCharacters[index].asciiValue!) - 97
            let targetIndex = Int(targetCharacters[index].asciiValue!) - 97

            frequencyDifference[sourceIndex] += 1
            frequencyDifference[targetIndex] -= 1
        }

        // Try changing the latest possible position.
        for index in stride(
            from: targetCharacters.count - 1,
            through: 0,
            by: -1
        ) {
            let currentCharacterIndex =
                Int(targetCharacters[index].asciiValue!) - 97

            // Release this target character because this position
            // is now allowed to change.
            frequencyDifference[currentCharacterIndex] += 1

            // If any frequency is negative, the unchanged prefix
            // cannot be constructed from `s`.
            if frequencyDifference.min()! < 0 {
                continue
            }

            // There is no lowercase letter greater than 'z'.
            // This guard prevents constructing the invalid range 26...25.
            guard currentCharacterIndex < 25 else {
                continue
            }

            // Find the smallest available character strictly greater
            // than the current target character.
            for replacementIndex in (currentCharacterIndex + 1)...25
            where frequencyDifference[replacementIndex] > 0 {

                frequencyDifference[replacementIndex] -= 1

                targetCharacters[index] = Character(
                    UnicodeScalar(replacementIndex + 97)!
                )

                let prefix = String(targetCharacters[0...index])

                return prefix + makeMinimumString(
                    from: frequencyDifference
                )
            }
        }

        return ""
    }

    private func makeMinimumString(from frequencies: [Int]) -> String {
        var bytes: [UInt8] = []

        // Build the lexicographically smallest possible suffix.
        for (characterIndex, frequency) in frequencies.enumerated()
        where frequency > 0 {
            for _ in 0..<frequency {
                bytes.append(UInt8(characterIndex + 97))
            }
        }

        return String(decoding: bytes, as: UTF8.self)
    }
}