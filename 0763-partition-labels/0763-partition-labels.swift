class Solution {
    func partitionLabels(_ s: String) -> [Int] {
        var lastOccurrence: [Character: Int] = [:] // Dictionary to store the last occurrence index of each character

        // Find the last occurrence of each character in the string
        for (index, char) in s.enumerated() {
            lastOccurrence[char] = index
        }

        var result: [Int] = [] // Array to store the lengths of the partitions
        var currentPartitionLength = 0 // Length of the current partition
        var currentPartitionEndIndex = 0 // End index of the current partition
        var currentIndex = 0 // Current index while iterating through the string

        // Iterate through the string to determine partition boundaries
        for char in s {
            let currentCharLastIndex = lastOccurrence[char]! // Get the last occurrence index of the current character
            currentPartitionEndIndex = max(currentPartitionEndIndex, currentCharLastIndex) // Extend the partition end if needed
            currentPartitionLength += 1 // Increase the length of the current partition

            // If the current index reaches the end of the current partition, it's a valid partition
            if currentIndex == currentPartitionEndIndex {
                result.append(currentPartitionLength) // Add the partition length to the result
                currentPartitionLength = 0 // Reset the partition length for the next partition
            }

            currentIndex += 1 // Move to the next character
        }

        return result // Return the array of partition lengths
    }
}