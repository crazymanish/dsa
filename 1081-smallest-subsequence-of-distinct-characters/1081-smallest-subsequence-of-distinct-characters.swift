class Solution {
    /**
     Problem Summary:
     Return the lexicographically smallest subsequence of `s` that contains
     every distinct character exactly once.

     Strategy:
     Use a monotonic stack to build the result. Before adding a new character,
     remove larger characters from the stack only if they appear again later,
     allowing them to be placed in a smaller lexicographic position.

     Time Complexity: O(n)
     Space Complexity: O(n)
     */
    func smallestSubsequence(_ s: String) -> String {
        var stack = [Character]()
        var includedCharacters = Set<Character>()

        // Tracks how many occurrences of each character remain to be processed.
        var remainingCount = Dictionary(s.map { ($0, 1) }, uniquingKeysWith: +)

        for character in s {
            // This occurrence is now being processed.
            remainingCount[character]! -= 1

            // Each character may appear only once in the result.
            if includedCharacters.contains(character) {
                continue
            }

            // Remove larger characters when they can safely be added again later.
            while let lastCharacter = stack.last,
                  lastCharacter > character,
                  remainingCount[lastCharacter]! > 0 {
                stack.removeLast()
                includedCharacters.remove(lastCharacter)
            }

            stack.append(character)
            includedCharacters.insert(character)
        }

        return String(stack)
    }
}