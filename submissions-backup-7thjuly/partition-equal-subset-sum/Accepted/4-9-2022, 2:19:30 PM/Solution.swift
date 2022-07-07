// https://leetcode.com/problems/partition-equal-subset-sum

// Using Top-Down approach
// https://www.geeksforgeeks.org/0-1-knapsack-problem-dp-10/
class Solution {
    func canPartition(_ nums: [Int]) -> Bool {
        var sum = 0
        for num in nums { sum += num }

        if sum % 2 != 0 { return false } // ODD sum (i.e 11) never Partition
        
        let expectedSum = sum/2
        let numsCount = nums.count
        var dpMatrix: [[Bool]] = Array(repeating: Array(repeating: false, count: (expectedSum + 1)), count: numsCount + 1)
        
        for i in 0...numsCount {
            for j in 0...expectedSum {
                if i == 0 || j == 0 {
                    dpMatrix[i][j] = false
                } else {
                    let currentNumber = nums[i-1]
                    
                    if currentNumber == j {
                        dpMatrix[i][j] = true        
                    } else if currentNumber < j {
                        dpMatrix[i][j] = dpMatrix[i-1][j-currentNumber] || dpMatrix[i-1][j]        
                    } else {
                        dpMatrix[i][j] = dpMatrix[i-1][j]  
                    }
                }
            }
        }
        
        return dpMatrix[numsCount][expectedSum]
    }
}

/* Using Recursion + DP Memorization-cache

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

        // Check cache if we already have result or not
        if let cacheValue = cache[currentIndex][sum] { return cacheValue }

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

        // Save result into cache
        cache[currentIndex][sum] = result

        return result
    }
}
*/