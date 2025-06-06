// Time Complexity: O(N)
// The code iterates through the input string of length N once. Inside the loop, the `while` condition
// also processes each character at most once (pushing and popping from the `robotHand`). The helper
// function `findSmallestAvailableCharacter` runs in constant time, O(26), as it iterates through a
// fixed-size array. Thus, the total time complexity is dominated by the single pass, making it O(N).
//
// Space Complexity: O(N)
// The `paperTape` and `robotHand` character arrays can, in the worst-case scenario, each store all N
// characters from the input string. The `characterFrequencies` array has a constant size of 26.
// Therefore, the space required scales linearly with the length of the input string, resulting in O(N).

class Solution {
    /// Constructs the lexicographically smallest string by processing characters with a robotic arm metaphor.
    ///
    /// - Parameter s: The input string.
    /// - Returns: The lexicographically smallest string possible.
    func robotWithString(_ s: String) -> String {
        // Frequency map to keep track of characters remaining in the original string `s`.
        var characterFrequencies = [Int](repeating: 0, count: 26)
        let asciiValueForA = Character("a").intValue
        for character in s {
            let characterIndex = character.intValue - asciiValueForA
            characterFrequencies[characterIndex] += 1
        }

        // `paperTape` holds the final resulting string.
        var paperTape = [Character]()
        // `robotHand` is a temporary stack to hold characters from `s`.
        var robotHand = [Character]()

        // Iterate through each character of the input string.
        for character in s {
            // The robot picks up the current character and holds it.
            robotHand.append(character)
            
            // Decrement the frequency of the picked-up character as it's no longer in the unprocessed part of `s`.
            let characterIndex = character.intValue - asciiValueForA
            characterFrequencies[characterIndex] -= 1

            // Check if the robot should write the character it's holding onto the paper tape.
            // This loop continues as long as the robot's hand is not empty and the character on top of its hand
            // is less than or equal to the smallest character that is still available in the remainder of the string.
            // This ensures we always append the smallest possible character to our result.
            while let lastCharacterInHand = robotHand.last,
                  lastCharacterInHand <= findSmallestAvailableCharacter(in: characterFrequencies) {
                paperTape.append(robotHand.removeLast())
            }
        }

        // After iterating through the entire string, append any remaining characters from the robot's hand to the paper tape.
        while let lastCharacterInHand = robotHand.last {
            paperTape.append(lastCharacterInHand)
            robotHand.removeLast()
        }
        
        return String(paperTape)
    }

    /// Finds the smallest character that has a non-zero count in the frequency array.
    ///
    /// - Parameter frequencies: An array representing the counts of characters 'a' through 'z'.
    /// - Returns: The smallest available character. Returns 'z' + 1 conceptually if no characters are left,
    ///            ensuring comparisons work correctly. A value like '{' might be returned.
    private func findSmallestAvailableCharacter(in frequencies: [Int]) -> Character {
        let asciiValueForA = 97
        for i in 0..<26 {
            if frequencies[i] > 0, let unicodeScalar = UnicodeScalar(i + asciiValueForA) {
                return Character(unicodeScalar)
            }
        }
        // If no characters are left, return a character greater than 'z' to stop the writing loop.
        // Unicode for '{' is 123, which is `asciiValueForZ` (122) + 1.
        return "{"
    }
}

/// Extension to get the integer ASCII value of a Character.
extension Character {
    var intValue: Int { Int(self.asciiValue ?? 0) }
}