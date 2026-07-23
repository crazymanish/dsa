/**
 * Problem Summary:
 * Count the number of distinct XOR values obtainable from all triplets.
 *
 * Strategy:
 * For n >= 3, the result is the smallest power of two strictly greater
 * than n. For smaller arrays, every element contributes one unique value.
 *
 * Time Complexity: O(log n)
 * Space Complexity: O(1)
 */
class Solution {
    func uniqueXorTriplets(_ nums: [Int]) -> Int {
        let elementCount = nums.count

        guard elementCount > 2 else {
            return elementCount
        }

        // Find the smallest power of two strictly greater than n.
        var result = 1
        while result <= elementCount {
            result <<= 1
        }

        return result
    }
}