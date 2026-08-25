/**
 * Problem Summary:
 * Find the smallest positive multiple of `k` that does not appear in `nums`.
 *
 * Strategy:
 * - Store all values from `nums` in a Set for O(1) average lookup.
 * - Start with `k`, the smallest positive multiple of `k`.
 * - Keep adding `k` while the current multiple exists in the set.
 * - Return the first multiple that is missing.
 *
 * Time Complexity:
 * O(n), where n is the number of elements in `nums`.
 *
 * Space Complexity:
 * O(n) for storing the elements in a Set.
 */
class Solution {
    func missingMultiple(_ nums: [Int], _ k: Int) -> Int {
        let existingNumbers = Set(nums)
        var currentMultiple = k

        // Check multiples of k in increasing order until one is missing.
        while existingNumbers.contains(currentMultiple) {
            currentMultiple += k
        }

        return currentMultiple
    }
}