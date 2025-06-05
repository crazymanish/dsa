class Solution {
    // Overall Time Complexity: O(L_s1 * α(C) + L_base * α(C))
    // Overall Space Complexity: O(C)

    func smallestEquivalentString(_ s1: String, _ s2: String, _ baseStr: String) -> String {
        // Initialize a mapping where each character initially maps to itself.
        // This acts as a parent array in a Disjoint Set Union (DSU) structure.
        // `parentMap[char]` stores the smallest equivalent character (representative) for `char`.
        // Time: O(C) where C is the size of the alphabet (26).
        // Space: O(C)
        var parentMap: [Character: Character] = [:]
        for charCode in Character("a").asciiValue!...Character("z").asciiValue! {
            let char = Character(UnicodeScalar(charCode))
            parentMap[char] = char
        }

        // Nested function to find the representative (smallest equivalent character) of a character.
        // Uses path compression for optimization.
        // Time: Amortized O(α(C)) where α is the inverse Ackermann function (nearly constant).
        func findRepresentative(_ char: Character) -> Character {
            // Base case: If a character maps to itself, it's the representative of its set.
            if parentMap[char]! == char {
                return char
            }
            // Path compression: Recursively find the representative and set it directly as the parent.
            parentMap[char] = findRepresentative(parentMap[char]!)
            return parentMap[char]!
        }

        // Nested function to unite two sets (characters) by making the smaller character's representative
        // the representative of the larger character's set.
        // Time: Amortized O(α(C))
        func uniteSets(_ char1: Character, _ char2: Character) {
            var rep1 = findRepresentative(char1) // Find representative of char1
            var rep2 = findRepresentative(char2) // Find representative of char2

            // If they are already in the same set, do nothing.
            if rep1 == rep2 {
                return
            }

            // Union by rank/size (here, union by character value):
            // Make the representative of the alphabetically larger character point to
            // the representative of the alphabetically smaller character.
            if rep1 < rep2 {
                parentMap[rep2] = rep1
            } else {
                parentMap[rep1] = rep2
            }
        }

        // Convert strings to character arrays for efficient index-based access.
        // Time: O(L_s1 + L_s2)
        // Space: O(L_s1 + L_s2)
        let s1Chars = Array(s1)
        let s2Chars = Array(s2)

        // Perform union operations based on the equivalence defined by s1 and s2.
        // This loop runs L_s1 times. Each `uniteSets` call is Amortized O(α(C)).
        // Time: O(L_s1 * α(C))
        for index in 0..<s1.count {
            uniteSets(s1Chars[index], s2Chars[index])
        }

        // Convert the base string using the final mappings.
        // This loop runs L_base times. Each `findRepresentative` call is Amortized O(α(C)).
        // Time: O(L_base * α(C))
        // Space: O(L_base) for the new array.
        let transformedBaseChars = Array(baseStr).map { findRepresentative($0) }
        
        // Convert the array of characters back to a String.
        // Time: O(L_base)
        return String(transformedBaseChars)
    }
}