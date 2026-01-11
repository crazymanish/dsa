class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(m * n)
    ///     - m = number of rows
    ///     - n = number of columns
    ///     Each cell is processed once to build heights,
    ///     and each row is processed in O(n) using a stack.
    ///
    /// Space Complexity:
    ///   • O(n)
    ///     - Stack for histogram calculation
    ///     - Heights array can be optimized to a single row
    ///
    /// Problem Summary:
    ///   Given a binary matrix filled with '0's and '1's,
    ///   find the largest rectangle containing only '1's.
    ///
    /// Approach:
    ///   1. Treat each row as the base of a histogram:
    ///        - heights[col] = number of consecutive '1's above (including current row)
    ///   2. For each histogram row, compute the largest rectangle
    ///      using a monotonic increasing stack.
    /// -----------------------------------------------------------------------
    func maximalRectangle(_ matrix: [[Character]]) -> Int {
        guard !matrix.isEmpty, !matrix[0].isEmpty else { return 0 }
        
        let rowCount = matrix.count
        let colCount = matrix[0].count
        
        // heights[col] = histogram height at this column
        var heights = Array(repeating: 0, count: colCount)
        var maximumArea = 0
        
        // Build histogram row by row
        for row in 0..<rowCount {
            for col in 0..<colCount {
                if matrix[row][col] == "1" {
                    heights[col] += 1
                } else {
                    heights[col] = 0
                }
            }
            
            // Compute max rectangle area for this histogram
            maximumArea = max(
                maximumArea,
                largestRectangleInHistogram(heights)
            )
        }
        
        return maximumArea
    }
    
    /// Computes the largest rectangle area in a histogram using a monotonic stack.
    private func largestRectangleInHistogram(_ heights: [Int]) -> Int {
        var indexStack = [Int]()   // stores indices of increasing heights
        var maxArea = 0
        
        for currentIndex in 0..<heights.count {
            let currentHeight = heights[currentIndex]
            
            // Pop while the current bar is lower than the last stacked bar
            while let lastIndex = indexStack.last,
                  heights[lastIndex] >= currentHeight {
                
                let height = heights[lastIndex]
                indexStack.removeLast()
                
                // Width is determined by current index and new stack top
                let width = currentIndex - (indexStack.last ?? -1) - 1
                maxArea = max(maxArea, height * width)
            }
            
            indexStack.append(currentIndex)
        }
        
        // Process remaining bars in the stack
        while let lastIndex = indexStack.popLast() {
            let height = heights[lastIndex]
            let width = heights.count - (indexStack.last ?? -1) - 1
            maxArea = max(maxArea, height * width)
        }
        
        return maxArea
    }
}
