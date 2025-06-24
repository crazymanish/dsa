// Time Complexity: O(n + m*k)
// O(n) to find all indices of the key, where `n` is the number of elements in `nums`.
// Then, for each of the `m` key indices, we iterate `k` positions in both directions.
// This is much better than the original O(n*m) for large inputs.
// The final sort takes O(p log p), where `p` is the number of items in the result set (at most `n`).

// Space Complexity: O(p)
// O(p) to store the result set, where `p` is the number of k-distant indices.
// O(m) to store the key indices, where `m` is the number of occurrences of the key.
// The dominant factor is the size of the output.
class Solution {
    /**
     * Finds all indices `i` in the `nums` array such that there exists at least one index `j`
     * where `nums[j] == key` and the absolute difference `|i - j| <= k`.
     *
     * - Parameters:
     * - nums: The input array of integers.
     * - key: The integer value to search for.
     * - k: The maximum allowed distance.
     * - Returns: A sorted array of the k-distant indices.
     */
    func findKDistantIndices(_ nums: [Int], _ key: Int, _ k: Int) -> [Int] {
        let numberCount = nums.count
        
        // Use a Set to automatically handle duplicate indices.
        var kDistantIndices: Set<Int> = []
        
        // First, find all occurrences of the `key`.
        let keyIndices = nums.indices.filter { nums[$0] == key }
        
        // If the key is not found, there are no k-distant indices.
        if keyIndices.isEmpty { return [] }
        
        // Instead of nested loops, iterate through each found key index once.
        // For each key index, add all valid indices within its k-distant range.
        for keyIndex in keyIndices {
            // Calculate the start and end of the k-distant window.
            // Clamp the values to the valid bounds of the array.
            let startIndex = max(0, keyIndex - k)
            let endIndex = min(numberCount - 1, keyIndex + k)
            
            // Add all indices in this window to our result set.
            for distantIndex in startIndex...endIndex {
                kDistantIndices.insert(distantIndex)
            }
        }
        
        // Convert the set to a sorted array as required by the problem.
        return Array(kDistantIndices.sorted())
    }
}