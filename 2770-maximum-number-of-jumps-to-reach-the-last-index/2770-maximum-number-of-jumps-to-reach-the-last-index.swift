class Solution {
    /**
     Problem Summary:
     Given an array `nums` and an integer `target`, find the maximum number of valid jumps
     needed to reach the last index from index `0`.

     A jump from index `i` to index `j` is valid when:
     - `i < j`
     - `abs(nums[j] - nums[i]) <= target`

     Strategy:
     Use dynamic programming where `maxJumpsToIndex[index]` stores the maximum number of
     jumps needed to reach `index`. Initialize index `0` with `0` jumps, then try every
     possible forward jump and update the destination if the jump is valid.

     Time Complexity:
     O(n²), because every pair of indices may be checked once.

     Space Complexity:
     O(n), for the DP array.
     */
    func maximumJumps(_ nums: [Int], _ target: Int) -> Int {
        let count = nums.count

        // maxJumpsToIndex[i] represents the maximum jumps needed to reach index i.
        // A value of -1 means index i is currently unreachable.
        var maxJumpsToIndex = Array(repeating: -1, count: count)
        maxJumpsToIndex[0] = 0

        for currentIndex in 0..<(count - 1) {
            // Skip unreachable indices because no valid path can continue from them.
            if maxJumpsToIndex[currentIndex] == -1 {
                continue
            }

            for nextIndex in (currentIndex + 1)..<count {
                let difference = abs(nums[nextIndex] - nums[currentIndex])

                // A jump is valid only if the value difference is within the target.
                if difference <= target {
                    maxJumpsToIndex[nextIndex] = max(maxJumpsToIndex[nextIndex], maxJumpsToIndex[currentIndex] + 1)
                }
            }
        }

        return maxJumpsToIndex[count - 1]
    }
}