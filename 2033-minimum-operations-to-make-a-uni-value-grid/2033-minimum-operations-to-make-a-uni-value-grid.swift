/**
 Problem Summary:
 Given a 2D grid of integers, you can add or subtract a fixed value `x` in one operation.
 The goal is to make all grid elements equal using the minimum number of operations.
 If it's not possible, return -1.

 Strategy:
 1. Flatten the grid into a 1D array for easier processing.
 2. Check feasibility:
    - All numbers must have the same remainder when divided by `x`.
    - Otherwise, it's impossible to make them equal.
 3. Sort the flattened array and choose the median as the target value:
    - The median minimizes the sum of absolute differences.
 4. Compute total operations required to convert all values to the median.

 Time Complexity:
 O(m * n log(m * n)) due to sorting.

 Space Complexity:
 O(m * n) for storing flattened array.
 */
class Solution {
    func minOperations(_ grid: [[Int]], _ x: Int) -> Int {
        let rowCount = grid.count
        let columnCount = grid[0].count
        
        // Flatten the 2D grid into a single array
        var flattenedValues: [Int] = []
        flattenedValues.reserveCapacity(rowCount * columnCount)
        
        for row in grid {
            for value in row {
                flattenedValues.append(value)
            }
        }
        
        // Check feasibility: all values must have same remainder modulo x
        let targetRemainder = flattenedValues[0] % x
        for value in flattenedValues {
            if value % x != targetRemainder {
                // Impossible to make all values equal
                return -1
            }
        }
        
        // Sort values to determine the median
        flattenedValues.sort()
        
        // Median minimizes total absolute distance
        let medianValue = flattenedValues[flattenedValues.count / 2]
        
        // Calculate total operations needed
        var totalOperations = 0
        
        for value in flattenedValues {
            // Each step changes value by x, so divide difference by x
            let operationsNeeded = abs(value - medianValue) / x
            totalOperations += operationsNeeded
        }
        
        return totalOperations
    }
}