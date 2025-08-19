// Time Complexity: O(N)
// The algorithm consists of a single loop that iterates through the `nums` array once.
// All operations inside the loop (comparison, addition, assignment) are constant time.
// Therefore, the runtime is directly proportional to the number of elements, N, in the input array.
//
// Space Complexity: O(1)
// The solution uses a fixed number of variables (`consecutiveZeroCount`, `totalSubarrays`)
// to store the running count and the final result. The amount of memory used does not
// scale with the size of the input array.
class Solution {
    /**
     * Counts the total number of contiguous subarrays filled entirely with zeros.
     *
     * - Parameter nums: An array of integers.
     * - Returns: The total count of zero-filled subarrays.
     */
    func zeroFilledSubarray(_ nums: [Int]) -> Int {
        // `consecutiveZeroCount` tracks the length of the current streak of zeros.
        var consecutiveZeroCount = 0
        
        // `totalSubarrays` accumulates the final result.
        var totalSubarrays = 0

        // We iterate through the array once to identify and count subarrays.
        for num in nums {
            if num == 0 {
                // If we encounter a zero, the current streak of zeros gets longer.
                consecutiveZeroCount += 1
            } else {
                // If we encounter a non-zero number, the streak is broken. Reset the counter.
                consecutiveZeroCount = 0
                // Skip to the next number as this one cannot start or extend a zero-filled subarray.
                continue
            }
            
            // --- The Core Insight ---
            // When we find a zero that extends a streak to length `k`, it creates `k` new subarrays.
            // These are the subarrays of lengths 1, 2, ..., k that all end at the current position.
            // By adding the current streak length to our total, we account for all these new subarrays.
            //
            // Example: [0, 0, 0]
            // 1. First 0: streak=1. Add 1. New subarrays: [0]. Total=1.
            // 2. Second 0: streak=2. Add 2. New subarrays: [0,0], [0]. Total=1+2=3.
            // 3. Third 0: streak=3. Add 3. New subarrays: [0,0,0], [0,0], [0]. Total=3+3=6.
            totalSubarrays += consecutiveZeroCount
        }
        
        return totalSubarrays
    }
}