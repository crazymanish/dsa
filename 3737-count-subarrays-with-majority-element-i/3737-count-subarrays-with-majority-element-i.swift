class Solution {
    /**
     Problem Summary:
     Count subarrays where `target` appears more than half of the subarray length.

     Strategy:
     Build a prefix count array where each index stores how many times `target`
     has appeared up to that position. Then check every subarray and count it
     if the target frequency is greater than half its length.

     Time Complexity: O(n²)
     Space Complexity: O(n)
     */
    func countMajoritySubarrays(_ nums: [Int], _ target: Int) -> Int {
        let count = nums.count
        var majoritySubarrayCount = 0
        var targetPrefixCount = Array(repeating: 0, count: count)

        // Build prefix count of target occurrences.
        for index in nums.indices {
            let previousCount = index > 0 ? targetPrefixCount[index - 1] : 0
            targetPrefixCount[index] = previousCount + (nums[index] == target ? 1 : 0)
        }

        // Check every possible subarray.
        for startIndex in 0..<count {
            for endIndex in startIndex..<count {
                let targetCountBeforeStart = startIndex > 0 ? targetPrefixCount[startIndex - 1] : 0
                let targetCountInSubarray = targetPrefixCount[endIndex] - targetCountBeforeStart
                let subarrayLength = endIndex - startIndex + 1

                // Target must appear more than half of the subarray length.
                if targetCountInSubarray * 2 > subarrayLength {
                    majoritySubarrayCount += 1
                }
            }
        }

        return majoritySubarrayCount
    }
}