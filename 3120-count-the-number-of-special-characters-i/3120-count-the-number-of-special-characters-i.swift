class Solution {
    /**
     Problem Summary:
     Count how many lowercase letters in `word` are "special".
     A letter is special if both its lowercase and uppercase forms appear in the string.

     Strategy:
     Store every character from `word` in a set for O(1) lookups.
     Then check each lowercase character and count it if its uppercase version also exists.

     Time Complexity:
     O(n), where n is the length of `word`.

     Space Complexity:
     O(k), where k is the number of unique characters in `word`.
     Since the input is alphabetic, this is effectively O(1).
     */
    func numberOfSpecialChars(_ word: String) -> Int {
        var seenCharacters = Set<Character>()

        // Store all characters so we can quickly check whether
        // the matching uppercase version exists.
        for character in word {
            seenCharacters.insert(character)
        }

        var specialCharacterCount = 0

        for character in seenCharacters {
            // Only count lowercase letters to avoid counting the same
            // special pair twice.
            guard character.isLowercase else {
                continue
            }

            let uppercaseCharacter = Character(character.uppercased())

            if seenCharacters.contains(uppercaseCharacter) {
                specialCharacterCount += 1
            }
        }

        return specialCharacterCount
    }
}