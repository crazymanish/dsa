class Solution {
    func getRow(_ rowIndex: Int) -> [Int] {
        var outputRow = [1]
        
        guard rowIndex > 0 else { return outputRow }
        
        for _ in 1...rowIndex {
            let previousRow = [0] + outputRow + [0]
            
            var currentRow: [Int] = []
            for index in 1...outputRow.count+1 {
                let currentValue = previousRow[index-1] + previousRow[index]
                currentRow.append(currentValue)
            }
            
            outputRow = currentRow
        }
        
        return outputRow
    }
}