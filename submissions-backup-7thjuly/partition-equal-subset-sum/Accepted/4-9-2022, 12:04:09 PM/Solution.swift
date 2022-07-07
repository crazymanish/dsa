// https://leetcode.com/problems/partition-equal-subset-sum

class Solution {
    var dpMemorizationCache: [Int : [Int : Bool]] = [:]

    func canPartition(_ nums: [Int]) -> Bool {
        var sum = 0
        for num in nums { sum += num }

        if sum % 2 != 0 { return false } // ODD sum (i.e 11) never Partition

        // Let's assume total sum was = 22 then we need to find a subset with equal 11
        // because rest remaining array elements sum will be left 11 automatically.
        return canPartition(nums, sum/2, nums.count-1)
    }

    // Knapsack problem variation - Dynamic Programming
    private func canPartition(_ nums: [Int], _ sum: Int, _ currentIndex: Int) -> Bool {
        if sum == 0 { return true }
        if currentIndex < 0 { return false }

        let currentNumber = nums[currentIndex]

        if currentNumber == sum { return true }

        if let cacheSum = dpMemorizationCache[sum], let cacheValue = cacheSum[currentIndex] {
            print("\(sum) \(currentIndex)")
            return cacheValue
        }

        var result = false

        if currentNumber < sum {
            // We have two choices:
            // Choice1: Consider current-number fit for Partition(subset), keep finding smaller sum in smaller array
            // Choice2: Ingore current-number fit for Partition, keep finding subset in smaller array
            result = canPartition(nums, sum-currentNumber, currentIndex-1) || canPartition(nums, sum, currentIndex-1)
        } else {
            // Only 1 choice:
            // current-number does not fit for Partition, so keep finding subset in smaller array
            result = canPartition(nums, sum, currentIndex-1)
        }

        var cacheSum = dpMemorizationCache[sum] ?? [:]
        cacheSum[currentIndex] = result
        dpMemorizationCache[sum] = cacheSum

        return result
    }
}
