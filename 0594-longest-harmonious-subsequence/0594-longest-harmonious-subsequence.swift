// Time Complexity: O(n)
// We iterate through the input array once to build the frequency map (O(n)),
// and then iterate through the unique keys in the map (O(u), where u <= n).
// The total time complexity is O(n + u), which simplifies to O(n).

// Space Complexity: O(u)
// The dictionary stores one entry for each unique number in the input array.
// 'u' is the number of unique elements.

class Solution {
    /**
     * Finds the length of the longest harmonious subsequence.
     * A harmonious subsequence is a subsequence where the difference between its
     * maximum and minimum value is exactly 1.
     *
     * - Parameter nums: An array of integers.
     * - Returns: The length of the longest harmonious subsequence.
     */
    func findLHS(_ nums: [Int]) -> Int {
        
        // --- Step 1: Count the frequency of each number. ---
        var frequencyMap: [Int: Int] = [:]
        for number in nums {
            // Use the default subscript for a more concise way to increment the count.
            frequencyMap[number, default: 0] += 1
        }
        
        // --- Step 2: Find the longest harmonious subsequence. ---
        var longestLength = 0
        
        // Iterate through each number and its count in the map.
        for (number, count) in frequencyMap {
            // Check if the map also contains the next consecutive number (number + 1).
            if let adjacentCount = frequencyMap[number + 1] {
                // If it exists, the length of this harmonious subsequence is the sum
                // of the counts of the two adjacent numbers.
                let currentLength = count + adjacentCount
                
                // Update the longest length found so far.
                longestLength = max(longestLength, currentLength)
            }
        }
        
        return longestLength
    }
}