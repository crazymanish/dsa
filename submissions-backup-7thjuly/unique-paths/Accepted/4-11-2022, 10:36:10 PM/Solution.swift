// https://leetcode.com/problems/unique-paths

class Solution {
    // https://www.youtube.com/watch?v=IlEsdxuD4lY
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        var lastRow = Array(repeating: 1, count: n)
        
        for rowIndex in (0..<m-1).reversed() { // m-1 (because we already have last row) 
            var currentRow = Array(repeating: 1, count: n)
            for columnIndex in (0..<n-1).reversed() {
                currentRow[columnIndex] = currentRow[columnIndex+1] + lastRow[columnIndex]
            }
            lastRow = currentRow
        }
        
        return lastRow[0]
    }
}