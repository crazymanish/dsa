// Time Complexity: O(N)
// The code iterates through the input string `num` exactly once. All operations inside
// the loop (character comparison, assignment, etc.) are constant time. Therefore, the
// runtime is directly proportional to the length of the string, N.
//
// Space Complexity: O(1)
// The solution uses a fixed number of variables to store the state (the max digit,
// the repeat count, and the previous character). The amount of memory used does not
// scale with the size of the input string.
class Solution {
    /**
     * Finds the largest "good integer" (a substring of three identical digits) in a string.
     *
     * - Parameter num: A string representing a large integer.
     * - Returns: The largest good integer as a string, or "" if none exists.
     */
    func largestGoodInteger(_ num: String) -> String {
        guard !num.isEmpty else { return "" }
        
        // Stores the largest digit found so far that forms a "good integer".
        // Using an optional is more idiomatic than a sentinel value like "-".
        var maxGoodDigit: Character? = nil
        
        // Tracks the number of times the previous character has repeated consecutively.
        var consecutiveRepeats = 1
        
        // We need to compare each character to the one before it.
        var previousChar = num.first!
        
        // Iterate through the string from the second character.
        for currentChar in num.dropFirst() {
            if currentChar == previousChar {
                // If the character is the same as the previous one, increment the count.
                consecutiveRepeats += 1
            } else {
                // Otherwise, reset the count for the new character.
                consecutiveRepeats = 1
            }
            
            // Update the previous character for the next iteration.
            previousChar = currentChar
            
            // If we have found exactly three consecutive digits...
            if consecutiveRepeats == 3 {
                // ...check if this digit is larger than the max we've seen so far.
                if maxGoodDigit == nil || currentChar > maxGoodDigit! {
                    maxGoodDigit = currentChar
                }
            }
        }
        
        // After checking the whole string, construct the result.
        if let digit = maxGoodDigit {
            return String(repeating: digit, count: 3)
        } else {
            // If maxGoodDigit is still nil, no good integer was found.
            return ""
        }
    }
}