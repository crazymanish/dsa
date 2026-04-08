class Solution {
    /**
     Problem Summary:
     Given an initial array `nums`, process each query of the form
     `[start, end, step, multiplier]`. For every index in the inclusive
     range `[start, end]` stepping by `step`, multiply `nums[index]` by
     `multiplier` modulo `1_000_000_007`. After all queries are applied,
     return the XOR of all final values.

     Strategy:
     Simulate each query directly:
     1. Copy `nums` into a mutable array.
     2. For each query, iterate through the affected indices using `stride`.
     3. Apply the modular multiplication in place.
     4. Compute the XOR of the final array.

     Time Complexity:
     O(total updated positions + n), where `n` is `nums.count`.

     Space Complexity:
     O(n), due to the mutable copy of `nums`.
     */
    func xorAfterQueries(_ nums: [Int], _ queries: [[Int]]) -> Int {
        let modulo = 1_000_000_007
        var updatedNums = nums

        // Apply each query by visiting only the indices affected by its step pattern.
        for query in queries {
            let startIndex = query[0]
            let endIndex = query[1]
            let step = query[2]
            let multiplier = query[3]

            // Update every index in [startIndex, endIndex] with the given stride.
            for index in stride(from: startIndex, through: endIndex, by: step) {
                updatedNums[index] = (updatedNums[index] * multiplier) % modulo
            }
        }

        // XOR all values after processing every query.
        return updatedNums.reduce(0, ^)
    }
}