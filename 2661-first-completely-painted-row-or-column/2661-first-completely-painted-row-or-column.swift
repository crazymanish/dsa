class Solution {
    func firstCompleteIndex(_ arr: [Int], _ mat: [[Int]]) -> Int {
        let rows = mat.count
        let cols = mat[0].count
        
        // Dictionary to store value -> position mapping
        var valueToPosition: [Int: (row: Int, col: Int)] = [:]
        
        // Build mapping of matrix values to their positions
        for i in 0..<rows {
            for j in 0..<cols {
                valueToPosition[mat[i][j]] = (i, j)
            }
        }
        
        // Arrays to track count of marked cells in each row and column
        var rowCounts = Array(repeating: 0, count: rows)
        var colCounts = Array(repeating: 0, count: cols)
        
        // Process array elements one by one
        for (index, value) in arr.enumerated() {
            // Get position of current value in matrix
            guard let position = valueToPosition[value] else { continue }
            
            // Increment counts for corresponding row and column
            rowCounts[position.row] += 1
            colCounts[position.col] += 1
            
            // Check if we have completed any row or column
            if rowCounts[position.row] == cols || 
               colCounts[position.col] == rows {
                return index
            }
        }
        
        return -1  // This case won't occur given problem constraints
    }
}