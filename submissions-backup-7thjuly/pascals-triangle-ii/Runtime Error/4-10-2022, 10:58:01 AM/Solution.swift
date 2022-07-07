// https://leetcode.com/problems/pascals-triangle-ii

class Solution {
    func getRow(_ rowIndex: Int) -> [Int] {
        var output = [[1]]
        
        for _ in 1...rowIndex {
            let previousRow = [0] + output.last! + [0]
            
            var currentRow: [Int] = []
            for index in 1...output.last!.count+1 {
                let currentValue = previousRow[index-1] + previousRow[index]
                currentRow.append(currentValue)
            }
            
            output.append(currentRow)
        }
        
        return output[rowIndex]
    }
}