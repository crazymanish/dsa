class Solution {
    /**
     Problem Summary:
     Given a list of lowercase words and a weight for each letter `a...z`,
     convert each word into a character by summing its letter weights,
     taking the result modulo 26, and mapping it backwards from `z`.

     Strategy:
     For each word:
     - Convert every character to its alphabet index.
     - Add the matching weight.
     - Reduce the total modulo 26.
     - Convert the value into a reversed alphabet character using `z - value`.

     Time Complexity:
     O(n * m), where `n` is the number of words and `m` is the average word length.

     Space Complexity:
     O(n), for the generated result characters.
     */
    func mapWordWeights(_ words: [String], _ weights: [Int]) -> String {
        let mappedCharacters = words.map { word -> Character in
            let wordWeight = calculateWordWeight(word, weights)
            let reversedAsciiValue = 122 - wordWeight

            return Character(UnicodeScalar(reversedAsciiValue)!)
        }

        return String(mappedCharacters)
    }

    private func calculateWordWeight(_ word: String, _ weights: [Int]) -> Int {
        var totalWeight = 0

        for character in word {
            guard let asciiValue = character.asciiValue else { continue }

            // Convert lowercase letter ASCII value into index: "a" -> 0, ..., "z" -> 25.
            let letterIndex = Int(asciiValue) - 97
            totalWeight += weights[letterIndex]
        }

        // Only the modulo value is needed to map back into the alphabet range.
        return totalWeight % 26
    }
}