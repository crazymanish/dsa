class Solution {
    func countPrefixSuffixPairs(_ words: [String]) -> Int {
        // Initialize the counter for valid pairs
        var count = 0

        func isPrefixAndSuffix(_ str1: String, _ str2: String) -> Bool {
            // Check if str1 is a prefix of str2
            let isPrefix = str2.hasPrefix(str1)
            
            // Check if str1 is a suffix of str2
            let isSuffix = str2.hasSuffix(str1)
    
            // Return true if both conditions are met
            return isPrefix && isSuffix
        }
    
        // Iterate through each pair of indices (i, j) where i < j
        for i in 0..<words.count {
            for j in (i+1)..<words.count {
                // Check if words[i] is both a prefix and a suffix of words[j]
                if isPrefixAndSuffix(words[i], words[j]) {
                    // Increment the counter if the condition is met
                    count += 1
                }
            }
        }
    
        // Return the total count of valid pairs
        return count
    }
}