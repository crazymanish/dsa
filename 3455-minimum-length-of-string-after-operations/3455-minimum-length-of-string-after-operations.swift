class Solution {
    func minimumLength(_ s: String) -> Int {
        // Dictionary to store the frequency of each character.
        var cache = [Character: Int]()
        // Variable to keep track of the current length of the string.
        var count = 0

        // Iterate through each character in the string.
        for char in s {
            // Increment the frequency count for the current character.
            cache[char, default: 0] += 1
            // Increment the overall count of characters.
            count += 1

            // If the character appears 3 times consecutively, adjust the count.
            if let cached = cache[char], cached == 3 {
                // Reset the frequency count for the character to 1.
                cache[char] = 1
                // Decrease the overall count by 2 to account for the removal of 2 characters.
                count -= 2
            }
        }

        // Return the final count of characters after all removals.
        return count
    }
}