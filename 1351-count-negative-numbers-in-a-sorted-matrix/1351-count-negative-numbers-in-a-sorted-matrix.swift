/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(m + n)
///     - m = number of rows
///     - n = number of columns
///     We move the column pointer left at most n times total
///     while iterating through all rows once.
///
/// Space Complexity:
///   • O(1)
///     Only constant extra space is used.
///
/// Problem Summary:
///   The grid is sorted in non-increasing order both row-wise and column-wise.
///   We want to count how many elements are negative.
///
/// Approach (Top-Right Pointer):
///   - Start from the top-right corner.
///   - For each row:
///       • Move left while the current value is negative.
///       • All elements to the right of the pointer are negative.
///   - Accumulate the count.
/// ---------------------------------------------------------------------------

class Solution {
    func countNegatives(_ grid: [[Int]]) -> Int {
        let rows = grid.count
        let cols = grid[0].count
        
        var columnPointer = cols - 1
        var negativeCount = 0
        
        // Traverse each row
        for row in 0..<rows {
            // Move left while elements are negative
            while columnPointer >= 0 && grid[row][columnPointer] < 0 {
                columnPointer -= 1
            }
            
            // All elements to the right of columnPointer are negative
            negativeCount += cols - columnPointer - 1
        }
        
        return negativeCount
    }
}
