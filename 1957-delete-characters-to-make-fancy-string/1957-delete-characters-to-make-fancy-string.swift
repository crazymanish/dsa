/*
Time Complexity: O(N)
The algorithm iterates through the input string of length N exactly once. Each operation inside the loop takes constant time on average.

Space Complexity: O(N)
A new character array (or string) is created, which in the worst case (no consecutive characters) will have the same length as the input string.
*/
class Solution {
    /// Removes any character that appears three or more times consecutively.
    /// For example, "aaabbbccc" becomes "aabbcc".
    func makeFancyString(_ s: String) -> String {
        // Using an array of characters is more efficient than repeatedly appending to a string.
        var fancyChars: [Character] = []
        
        for char in s {
            // Check if the current character would be the third consecutive one.
            if fancyChars.count >= 2 &&
               fancyChars[fancyChars.count - 1] == char &&
               fancyChars[fancyChars.count - 2] == char {
                // If so, skip adding it.
                continue
            } else {
                // Otherwise, add it to our array.
                fancyChars.append(char)
            }
        }
        
        return String(fancyChars)
    }
}