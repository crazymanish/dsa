// Time Complexity: O(N²)
// The outer `while` loop runs N-1 times. The inner `for` loop's iterations decrease
// from N-1 down to 1. The total number of core operations is the sum
// (N-1) + (N-2) + ... + 1, which is proportional to N².
//
// Space Complexity: O(N)
// In each iteration, a new array `currentRow` is created to store the next row's
// values. The maximum size of this array is N-1, leading to space complexity
// that is linear with the input size.
class Solution {
    func triangularSum(_ nums: [Int]) -> Int {
        // `outputRow` holds the current row of numbers being processed.
        // It's initialized with the input array.
        var outputRow = nums
        
        // The process continues until only one number remains in the row.
        while outputRow.count > 1 {
            // `currentRow` will store the next row generated from `outputRow`.
            var currentRow: [Int] = []
            
            // Iterate through all adjacent pairs in the current `outputRow`.
            for index in 0..<outputRow.count-1 {
                // Calculate the sum of the adjacent elements.
                let currentValue = outputRow[index] + outputRow[index+1]
                // The new value is the sum modulo 10 (i.e., the last digit).
                currentRow.append(currentValue % 10)
            }
            
            // The newly generated row becomes the current row for the next iteration.
            outputRow = currentRow
        }
        
        // When the loop finishes, outputRow contains the single, final triangular sum.
        return outputRow[0]
    }
}