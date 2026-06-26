class Solution {
    /**
     Problem Summary:
     Count subarrays where `target` appears more than half of the subarray length.

     Strategy:
     Convert each number into a balance value:
     - `+1` if the number equals `target`
     - `-1` otherwise

     A subarray has `target` as the majority when its balance sum is positive.
     We track prefix-balance frequencies and count how many previous balances
     are smaller than the current balance.

     Time Complexity: O(n)
     Space Complexity: O(n)
     */
    func countMajoritySubarrays(_ nums: [Int], _ target: Int) -> Int {
        let count = nums.count
        let offset = count

        // `balanceFrequency[index]` stores how often a shifted balance has appeared.
        var balanceFrequency = Array(repeating: 0, count: count * 2 + 1)

        var shiftedBalance = offset
        var smallerPrefixBalanceCount = 0
        var majoritySubarrayCount = 0

        // Empty prefix has balance 0, shifted by `offset`.
        balanceFrequency[offset] = 1

        for num in nums {
            if num == target {
                // Moving balance up by 1 means prefixes with the old balance
                // are now smaller than the current balance.
                smallerPrefixBalanceCount += balanceFrequency[shiftedBalance]
                shiftedBalance += 1
            } else {
                // Moving balance down by 1 means prefixes with the new balance
                // are no longer smaller than the current balance.
                shiftedBalance -= 1
                smallerPrefixBalanceCount -= balanceFrequency[shiftedBalance]
            }

            // Store this prefix balance for future subarrays.
            balanceFrequency[shiftedBalance] += 1

            // Every smaller previous prefix balance forms a valid majority subarray.
            majoritySubarrayCount += smallerPrefixBalanceCount
        }

        return majoritySubarrayCount
    }
}