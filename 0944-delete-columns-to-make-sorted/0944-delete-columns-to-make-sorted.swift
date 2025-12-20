/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(m * n)
///     - m = number of strings (A.count)
///     - n = length of each string
///     We check every column and compare characters row by row.
///
/// Space Complexity:
///   • O(1)
///     Only constant extra space is used.
///
/// Problem Summary:
///   We want to count how many columns must be deleted so that
///   each remaining column is non-decreasing from top to bottom.
///
///   If for any column there exists a row i such that:
///       A[i][column] < A[i - 1][column]
///   then that column must be deleted.
/// ---------------------------------------------------------------------------

class Solution {
    func minDeletionSize(_ strings: [String]) -> Int {
        guard let first = strings.first else { return 0 }
        
        let rowCount = strings.count
        let columnCount = first.count
        
        var deletedColumns = 0
        
        // Iterate over each column index
        for column in 0..<columnCount {
            // Convert column offset into a String.Index (safe for Swift strings)
            let columnIndex = first.index(first.startIndex, offsetBy: column)
            
            // Compare characters vertically down the column
            for row in 1..<rowCount {
                let currentChar = strings[row][columnIndex]
                let previousChar = strings[row - 1][columnIndex]
                
                // If column is not sorted, mark it for deletion
                if currentChar < previousChar {
                    deletedColumns += 1
                    break
                }
            }
        }
        
        return deletedColumns
    }
}
