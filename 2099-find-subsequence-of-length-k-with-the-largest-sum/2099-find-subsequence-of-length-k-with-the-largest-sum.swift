// Time Complexity: O(n log n)
// The complexity is dominated by the sorting operations.
// - First sort (by value): O(n log n)
// - Second sort (by index): O(k log k)
// Total complexity is O(n log n) as n > k.

// Space Complexity: O(n)
// We create an intermediate array of tuples `indexedNumbers` to store
// both the value and original index for each number, which requires O(n) space.
class Solution {
    /**
     * Finds a subsequence of length `k` that has the largest possible sum.
     * The relative order of the elements in the subsequence must be the same as in the original array.
     *
     * - Parameters:
     * - nums: The input array of integers.
     * - k: The desired length of the subsequence.
     * - Returns: The subsequence of length `k` with the largest sum.
     */
    func maxSubsequence(_ nums: [Int], _ k: Int) -> [Int] {
        // --- Step 1: Pair each number with its original index ---
        // We need the original index to restore the order later.
        // `(value: Int, originalIndex: Int)`
        let indexedNumbers = nums.enumerated().map { (index, value) in
            return (value: value, originalIndex: index)
        }
        
        // --- Step 2: Find the k largest numbers ---
        // Sort by value in descending order and take the first `k` elements.
        let kLargest = indexedNumbers.sorted { $0.value > $1.value }.prefix(k)
        
        // --- Step 3: Restore the original relative order ---
        // Sort the `k` largest elements back by their original index.
        let sortedSubsequence = kLargest.sorted { $0.originalIndex < $1.originalIndex }
        
        // --- Step 4: Extract just the numbers ---
        // Map the result back to an array of just the integer values.
        let result = sortedSubsequence.map { $0.value }
        
        return result
    }
}