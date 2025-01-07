class Solution {
    func stringMatching(_ words: [String]) -> [String] {
        // Sort the words by length to optimize the substring checking process
        let sortedWords = words.sorted { $0.count < $1.count }
    
        // Initialize a set to store the result
        var resultSet = Set<String>()
    
        // Iterate through the sorted words
        for i in 0..<sortedWords.count {
            // Check if the current word is a substring of any longer word
            for j in (i+1)..<sortedWords.count {
                // If the current word is a substring of the longer word, add it to the result set
                if sortedWords[j].contains(sortedWords[i]) {
                    resultSet.insert(sortedWords[i])
                    break // Break out of the inner loop to avoid unnecessary comparisons
                }
            }
        }
    
        // Convert the set to an array and return the result
        return Array(resultSet)
    }
}