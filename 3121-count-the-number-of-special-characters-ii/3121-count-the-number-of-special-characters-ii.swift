class Solution {
    /**
     Problem Summary:
     Count how many letters are "special" in `word`.
     A letter is special if:
     - Its lowercase and uppercase forms both appear.
     - Every lowercase occurrence appears before every uppercase occurrence.

     Strategy:
     Scan the word from left to right.
     Track lowercase characters already seen.
     Track uppercase characters already seen.
     Track valid special characters.
     If a lowercase character appears after any uppercase version of itself,
     that letter becomes invalid and cannot be special.

     Time Complexity:
     O(n), where n is the length of `word`.

     Space Complexity:
     O(1), because there are at most 26 English letters.
     */
    func numberOfSpecialChars(_ word: String) -> Int {
        var seenLowercase = Set<Character>()
        var seenUppercase = Set<Character>()
        var specialCharacters = Set<Character>()
        var invalidCharacters = Set<Character>()

        for character in word {
            if character.isLowercase {
                let uppercaseCharacter = Character(character.uppercased())

                // If uppercase appeared before this lowercase,
                // the ordering rule is broken permanently.
                if seenUppercase.contains(uppercaseCharacter) {
                    specialCharacters.remove(character)
                    invalidCharacters.insert(character)
                }

                seenLowercase.insert(character)
            } else {
                let lowercaseCharacter = Character(character.lowercased())

                seenUppercase.insert(character)

                // Uppercase can only make a character special if:
                // 1. Its lowercase appeared earlier.
                // 2. It has not been invalidated by bad ordering.
                if seenLowercase.contains(lowercaseCharacter),
                   !invalidCharacters.contains(lowercaseCharacter) {
                    specialCharacters.insert(lowercaseCharacter)
                }
            }
        }

        return specialCharacters.count
    }
}