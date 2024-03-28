class Solution {
    func maxSubarrayLength(_ nums: [Int], _ k: Int) -> Int {
        var left = 0, right = 0
        var count: [Int: Int] = [:] // Number: Frequency
        var longest = Int.min

        while right < nums.count {
            count[nums[right], default: 0] += 1

            while count[nums[right], default: 0] > k, left < nums.count {
                count[nums[left], default: 0] -= 1
                left += 1 // we move left until it satisfies numbers are less than K
            }

            longest = max(longest, right - left + 1)
            right += 1 // we keep expanding the subarray
        }

        return longest
    }
}