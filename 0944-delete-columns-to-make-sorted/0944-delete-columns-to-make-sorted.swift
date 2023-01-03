class Solution {
    func minDeletionSize(_ A: [String]) -> Int {
        var deletedColumnCount = 0
        
        for column in 0..<A[0].count {
            let columnIndex = A[0].utf16.index(A[0].utf16.startIndex, offsetBy: column)
            
            for row in 1..<A.count {
                if A[row][columnIndex] < A[row - 1][columnIndex] {
                    deletedColumnCount += 1
                    break
                }
            }
        }
        
        return deletedColumnCount
    }
}