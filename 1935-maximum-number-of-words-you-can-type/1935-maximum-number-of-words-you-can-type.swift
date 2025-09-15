// Time Complexity: O(T + B)
//   - T: The length of the `text` string.
//   - B: The length of the `brokenLetters` string.
//   - Building the set of broken characters takes O(B).
//   - Splitting the text into words and filtering it effectively iterates through all
//     characters of the text once. This takes O(T).
//   - The overall complexity is linear with respect to the total input size.
//
// Space Complexity: O(T + B)
//   - The `brokenCharsSet` requires O(B) space.
//   - The `words` array created by splitting the text requires O(T) space.

/**
 * Provides a solution to the "Determine if a Word Can Be Typed" problem.
 * This implementation showcases a concise, functional programming style common in
 * modern Swift, using high-order functions like `filter` and `allSatisfy`.
 */
class Solution {
    /**
     * Counts the number of words in a text that can be typed with a given set of broken keyboard letters.
     *
     * This functional approach first creates a `Set` of broken letters for efficient `O(1)` lookup.
     * It then splits the text into an array of words and uses the `filter` method to create a new
     * array containing only the "typable" words. A word is considered typable if the `allSatisfy`
     * method confirms that none of its characters are present in the set of broken letters. Finally,
     * the function returns the count of this filtered array.
     *
     * - Parameter text: A string of words separated by spaces.
     * - Parameter brokenLetters: A string containing all the characters that cannot be typed.
     * - Returns: The count of words from `text` that are fully typable.
     */
    func canBeTypedWords(_ text: String, _ brokenLetters: String) -> Int {
        // Step 1: Create a Set for fast lookup of broken characters.
        let brokenCharsSet = Set(brokenLetters)
        
        // Step 2: Split the text into words.
        let words = text.components(separatedBy: " ")
        
        // Step 3: Filter the words list and return the count of the result.
        return words.filter { word in
            // A word is kept if `allSatisfy` returns true for its characters.
            word.allSatisfy { char in
                // The condition for a character to satisfy is that it must NOT be in the broken set.
                !brokenCharsSet.contains(char)
            }
        }.count
    }
}