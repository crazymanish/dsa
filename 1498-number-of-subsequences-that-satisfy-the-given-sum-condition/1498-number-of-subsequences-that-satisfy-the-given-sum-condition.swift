// Time Complexity: O(n log n)
// The complexity is dominated by the initial sort of the input array, which is O(n log n).
// The precomputation of powers and the two-pointer traversal are both O(n).

// Space Complexity: O(n)
// We create two additional arrays: one for the sorted numbers and another for the
// precomputed powers of two. Both require O(n) space.

class Solution {
    /**
     * Counts the number of non-empty subsequences where the sum of the minimum and maximum
     * elements is less than or equal to the target.
     *
     * - Parameters:
     * - nums: An array of integers.
     * - target: The target sum.
     * - Returns: The number of valid subsequences modulo 1,000,000,007.
     */
    func numSubseq(_ nums: [Int], _ target: Int) -> Int {
        let MOD = 1_000_000_007
        let count = nums.count
        
        // --- Step 1: Precompute powers of 2 ---
        // For a fixed minimum element `nums[i]`, if `nums[j]` is the maximum element,
        // we can form subsequences by including or excluding any of the `j - i - 1` elements
        // in between. This gives 2^(j-i) possible subsequences.
        var powersOfTwo = [Int](repeating: 0, count: count + 1)
        powersOfTwo[0] = 1
        for i in 1...count {
            powersOfTwo[i] = (2 * powersOfTwo[i-1]) % MOD
        }

        // --- Step 2: Sort the input array ---
        // Sorting allows us to use the two-pointer approach.
        let sortedNums = nums.sorted()
        
        // --- Step 3: Two-Pointer Traversal ---
        var leftPointer = 0
        var rightPointer = count - 1
        var validSubsequenceCount = 0
        
        while leftPointer <= rightPointer {
            let minElement = sortedNums[leftPointer]
            let maxElement = sortedNums[rightPointer]
            
            if minElement + maxElement > target {
                // The sum is too large. The maximum element (`rightPointer`) is too big for any
                // element starting from `leftPointer`, so we move the right pointer inward.
                rightPointer -= 1
            } else {
                // The sum is valid. This means `minElement` can form a valid pair with `maxElement`
                // and any other element between `leftPointer` and `rightPointer`.
                // The number of elements between them (inclusive of maxElement) is `rightPointer - leftPointer`.
                // The number of subsequences we can form with `minElement` fixed is 2^(rightPointer - leftPointer).
                let subsequencesToAdd = powersOfTwo[rightPointer - leftPointer]
                validSubsequenceCount = (validSubsequenceCount + subsequencesToAdd) % MOD
                
                // We've counted all subsequences for the current `leftPointer`, so move it forward.
                leftPointer += 1
            }
        }
        
        return validSubsequenceCount
    }
}