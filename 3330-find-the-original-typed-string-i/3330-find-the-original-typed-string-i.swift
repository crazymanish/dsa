// Time Complexity: O(n)
// The code iterates through the input string once. 'n' is the length of the string.

// Space Complexity: O(1)
// The algorithm uses a fixed amount of extra space regardless of the input size,
// as it iterates over the string's characters without creating a large new data structure.

class Solution {
    /**
     * Calculates a count based on runs of consecutive identical characters.
     * The logic adds `run_length - 1` for each run of identical characters to a base count of 1.
     *
     * - Parameter s: The input string.
     * - Returns: The calculated count.
     */
    func possibleStringCount(_ s: String) -> Int {
        // If the string is empty, there are no runs to consider.
        guard let firstChar = s.first else { return 0 }

        // The count starts at 1, representing a base case.
        var count = 1
        var consecutiveRunLength = 0
        var previousChar = firstChar

        for currentChar in s {
            if currentChar == previousChar {
                // The run of identical characters continues.
                consecutiveRunLength += 1
            } else {
                // The run has been broken by a new character.
                // Add the contribution from the previous run to the total count.
                count += consecutiveRunLength - 1
                
                // Reset the run length for the new character.
                consecutiveRunLength = 1
                previousChar = currentChar
            }
        }
        
        // After the loop, add the contribution from the very last run in the string.
        count += consecutiveRunLength - 1
        
        return count
    }
}