class Solution {
    func countFairPairs(_ nums: [Int], _ lower: Int, _ upper: Int) -> Int {
        // Step 1: Sort the array
        let sortedNums = nums.sorted()
        var count = 0

        // Step 2: Iterate through the array
        for i in 0..<sortedNums.count {
            let current = sortedNums[i]

            // Step 3: Use binary search to find valid pairs
            let lowIndex = lowerBound(sortedNums, i + 1, sortedNums.count - 1, lower - current)
            let highIndex = upperBound(sortedNums, i + 1, sortedNums.count - 1, upper - current)
        
            // Step 4: Add the count of valid indices
            count += max(0, highIndex - lowIndex + 1)
        }
    
        return count
    }

    // Helper function to find the lower bound (first index where nums[index] >= value)
    func lowerBound(_ nums: [Int], _ start: Int, _ end: Int, _ value: Int) -> Int {
        var left = start
        var right = end
        
        while left <= right {
            let mid = left + (right - left) / 2
            if nums[mid] < value {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        return left
    }

    // Helper function to find the upper bound (last index where nums[index] <= value)
    func upperBound(_ nums: [Int], _ start: Int, _ end: Int, _ value: Int) -> Int {
        var left = start
        var right = end
        
        while left <= right {
            let mid = left + (right - left) / 2
            if nums[mid] <= value {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        return right
    }
}

/*
let nums = [1, 2, 3, 4]
let lower = 3
let upper = 6
Execution:

Sort nums: [1, 2, 3, 4]
Iterate through the array:

For i = 0, current = 1:
lowerBound = 1 (nums[1] = 2, valid start)
upperBound = 2 (nums[2] = 3, valid end)

Pairs: (1, 2), (1, 3)
For i = 1, current = 2:
lowerBound = 2 (nums[2] = 3, valid start)
upperBound = 3 (nums[3] = 4, valid end)

Pairs: (2, 3), (2, 4)
For i = 2, current = 3:
lowerBound = 3, upperBound = 3
Pair: (3, 4)

For i = 3, current = 4:
No valid pairs.
*/