class Solution {
    func minOperations(_ grid: [[Int]], _ x: Int) -> Int {
        let m = grid.count
        let n = grid[0].count
        var nums = [Int]()

        // Flatten the grid into a single array
        for row in grid {
            for num in row {
                nums.append(num)
            }
        }

        // Check if all numbers have the same remainder when divided by x
        let remainder = nums[0] % x
        for num in nums {
            if num % x != remainder {
                return -1 // Not possible to make uni-value
            }
        }

        // Sort the array to find the median
        nums.sort()
        let median = nums[nums.count / 2]

        // Calculate the total operations needed to make all numbers equal to the median
        var operations = 0
        for num in nums {
            operations += abs(num - median) / x
        }

        return operations
    }
}