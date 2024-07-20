class Solution {
    func restoreMatrix(_ rowSum: [Int], _ colSum: [Int]) -> [[Int]] {
        var inRowSum = rowSum
        var inColSum = colSum
        let rows = Array(repeating: 0, count: colSum.count)
        var matrix = Array(repeating: rows, count: rowSum.count)
        
        for i in 0 ..< inRowSum.count {
            for j in 0 ..< inColSum.count {
                let maxDigit = min(inColSum[j], inRowSum[i])
                
                matrix[i][j] = maxDigit 
                inColSum[j] = inColSum[j] - maxDigit
                inRowSum[i] = inRowSum[i] - maxDigit
            }
        }
        
        return matrix
    }
}