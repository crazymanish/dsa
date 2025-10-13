// Time Complexity: O(N * L)
// where N is the number of words and L is the maximum length of a word.
// We iterate through each of the N words. For each word, we compute its
// character frequency map, which takes O(L) time.
//
// Space Complexity: O(N * L)
// A mutable copy of the input array (`stack`) is created, and the `results`
// array can grow to the size of the original input in the worst case.
class Solution {
    func removeAnagrams(_ words: [String]) -> [String] {
        // `results` will store the final list, but built in reverse order.
        var results: [String] = []
        // Create a mutable copy that we can process by removing elements from the end.
        var stack = words
        
        // Process words from the end of the list to the beginning.
        while !stack.isEmpty {
            // Get the last word from our processing stack.
            let last = stack.removeLast()
            // Calculate its character frequency map to check for anagrams.
            let lastAn = last.annogramCounting
            
            // If the stack is now empty, it means `last` was the very first word in
            // the original list, so it must be included.
            guard !stack.isEmpty else {
                results.append(last)
                return results.reversed()
            }
            
            // Compare the current word's map with the map of the *previous* word
            // in the original sequence (which is now at the end of the stack).
            if !(stack.last!.annogramCounting == lastAn) {
                // If they are not anagrams, the current word is not a consecutive
                // anagram of its predecessor, so we keep it.
                results.append(last)
            }
        }
        
        // The results were added from the end of the original list to the start,
        // so the final array must be reversed to restore the correct order.
        return results.reversed()
    }
}

extension String {
    /// Creates a frequency map of characters ('a' through 'z') for a string.
    /// Two strings are anagrams if their frequency maps are identical.
    var annogramCounting: [Int] {
        // Initialize an array of 26 zeros, one for each letter of the alphabet.
        var arr: [Int] = Array(repeating: 0, count: 26)
        // Iterate through each character in the string.
        for i in self.unicodeScalars {
            // Convert the character's Unicode value to a 0-25 index.
            // (e.g., 'a' has a value of 97, so 97 - 97 = 0).
            arr[Int(i.value) - 97] += 1
        }
        return arr
    }
}