class Solution {
    func numSubmatrixSumTarget(_ matrix: [[Int]], _ target: Int) -> Int {
        let rows = matrix.count
        let columns = matrix[0].count
        
        var answer = 0

        for row1 in 0..<rows {
            var sums = Array(repeating: 0, count: columns)
            for row2 in row1..<rows {
                var sumFreq: [Int: Int] = [0: 1]
                
                var rowSum = 0
                for column in 0..<columns {
                    rowSum += matrix[row2][column]
                    sums[column] += rowSum

                    if let count = sumFreq[sums[column] - target] {
                        answer += count
                    }
                    
                    sumFreq[sums[column], default: 0] += 1
                }
            }
        }

        return answer
    }
}