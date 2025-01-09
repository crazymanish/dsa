class Solution {
    func prefixCount(_ words: [String], _ pref: String) -> Int {
        // Initialize a counter to keep track of the number of words with the given prefix
        var count = 0
    
        // Iterate through each word in the words array
        for word in words {
            // Check if the word starts with the given prefix
            if word.hasPrefix(pref) {
                // If it does, increment the counter
                count += 1
            }
        }
    
        // Return the final count of words with the given prefix
        return count
    }
}