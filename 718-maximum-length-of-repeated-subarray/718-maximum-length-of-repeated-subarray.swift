class Solution {
    // Ditto question: Longest common substring
    func findLength(_ nums1: [Int], _ nums2: [Int]) -> Int {
        let rows = nums1
        let columns = nums2
        
        let rowsCount = rows.count
        let columnsCount = columns.count
        
        var dpMatrix = Array(repeating: Array(repeating: 0, count: columnsCount+1), count: rowsCount+1)
        var output = 0
        
        for rowIndex in 1...rowsCount {
            let currentRowValue = rows[rowIndex-1]
            for columnIndex in 1...columnsCount {
                let currentColumnValue = columns[columnIndex-1]
                
                if currentRowValue == currentColumnValue {
                    let previousLength = dpMatrix[rowIndex-1][columnIndex-1]
                    let newLength = 1 + previousLength
                    dpMatrix[rowIndex][columnIndex] = newLength
                    
                    output = max(output, newLength)
                }
            }
        }
        
        return output
    }
}