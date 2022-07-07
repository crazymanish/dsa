// https://leetcode.com/problems/partition-equal-subset-sum

class Solution {
    func canPartition(_ nums: [Int]) -> Bool {
        var sum = 0
        for num in nums { sum += num }

        if sum % 2 != 0 { return false } // ODD sum (i.e 11) never Partition
        
        var dpMemorizationCache: [[Bool?]] = Array(repeating: Array(repeating: nil, count: (sum/2 + 1)), count: nums.count + 1)

        // Let's assume total sum was = 22 then we need to find a subset with equal 11
        // because rest remaining array elements sum will be left 11 automatically.
        return canPartition(nums, sum/2, nums.count-1, &dpMemorizationCache)
    }

    // Knapsack problem variation - Dynamic Programming
    private func canPartition(_ nums: [Int], _ sum: Int, _ currentIndex: Int, _ cache: inout [[Bool?]]) -> Bool {
        if sum == 0 { return true }
        if currentIndex < 0 { return false }

        let currentNumber = nums[currentIndex]

        if currentNumber == sum { return true }

        if let cacheValue = cache[currentIndex][sum] {
            return cacheValue
        }

        var result = false

        if currentNumber < sum {
            // We have two choices:
            // Choice1: Consider current-number fit for Partition(subset), keep finding smaller sum in smaller array
            // Choice2: Ingore current-number fit for Partition, keep finding subset in smaller array
            result = canPartition(nums, sum-currentNumber, currentIndex-1, &cache) || canPartition(nums, sum, currentIndex-1, &cache)
        } else {
            // Only 1 choice:
            // current-number does not fit for Partition, so keep finding subset in smaller array
            result = canPartition(nums, sum, currentIndex-1, &cache)
        }

        cache[currentIndex][sum] = result

        return result
    }
}
