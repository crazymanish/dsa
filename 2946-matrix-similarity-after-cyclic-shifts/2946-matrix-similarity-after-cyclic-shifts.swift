class Solution {
    /**
     Problem Summary:
     Given a grid, each row is cyclically shifted:
     - Even-indexed rows are shifted right by k steps
     - Odd-indexed rows are shifted left by k steps
     
     Determine if after these shifts, every element remains in the same position
     (i.e., the grid remains unchanged).
     
     Strategy:
     - For each row, compute effective shift = k % numberOfColumns
     - For each element, calculate the index it should map to after shifting
     - Compare the current value with the value at the expected shifted index
     - If all elements match their expected positions → return true
     
     Time Complexity: O(m * n)
     - m = number of rows, n = number of columns
     
     Space Complexity: O(1)
     - No extra space used apart from variables
     */
    
    func areSimilar(_ grid: [[Int]], _ k: Int) -> Bool {
        let numberOfColumns = grid[0].count
        let effectiveShift = k % numberOfColumns
        
        return grid.enumerated().allSatisfy { (rowIndex, row) in
            
            return row.enumerated().allSatisfy { (columnIndex, value) in
                
                // Determine expected index after shift
                let expectedIndex: Int
                if rowIndex % 2 == 0 {
                    // Even row → right shift
                    expectedIndex = (columnIndex + effectiveShift) % numberOfColumns
                } else {
                    // Odd row → left shift
                    expectedIndex = (columnIndex - effectiveShift + numberOfColumns) % numberOfColumns
                }
                
                // Check if value matches expected shifted position
                return value == row[expectedIndex]
            }
        }
    }
}