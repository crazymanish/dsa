/*
Time Complexity: O(N), where N is the number of elements in the nums array. The algorithm makes a single pass to build the frequency map (O(N)) and then iterates through the unique elements (at most N) to find the max frequency and filter, resulting in a linear runtime.

Space Complexity: O(U), where U is the number of unique elements in nums. The space is used to store the frequencyMap, which holds one entry for each unique number.
*/
class Solution {
    /**
     * Calculates the total frequency of elements that appear most frequently in an array.
     *
     * The strategy is a two-step process:
     * 1.  **Count Frequencies**: First, iterate through the input array to build a
     * frequency map (a dictionary) that stores how many times each number appears.
     * 2.  **Sum Max Frequencies**: Find the highest frequency value among all elements.
     * Then, identify how many different elements share this maximum frequency. The final
     * result is the maximum frequency multiplied by the number of elements that have it.
     *
     * For example, in `[1, 2, 2, 3, 1]`:
     * - The max frequency is 2.
     * - The elements with this frequency are `1` and `2`. There are 2 such elements.
     * - The total frequency is `2 * 2 = 4`.
     *
     * - Parameter nums: An array of integers.
     * - Returns: The total frequency of the most frequent elements.
     */
    func maxFrequencyElements(_ nums: [Int]) -> Int {
        // Step 1: Build a frequency map from the input array.
        // `reduce(into:)` is an efficient way to create the dictionary in a single pass.
        let frequencyMap = nums.reduce(into: [:]) { counts, element in
            counts[element, default: 0] += 1
        }
        
        // Find the highest frequency in the map.
        // If the map is empty (i.e., `nums` was empty), max() returns nil.
        guard let maxFrequency = frequencyMap.values.max() else {
            return 0
        }
        
        // Step 2: Filter the map to find how many elements have the max frequency.
        let elementsWithMaxFreqCount = frequencyMap.filter { $0.value == maxFrequency }.count
        
        // The total result is the max frequency multiplied by the number of elements that share it.
        let totalMaxFrequency = maxFrequency * elementsWithMaxFreqCount
        
        return totalMaxFrequency
    }
}