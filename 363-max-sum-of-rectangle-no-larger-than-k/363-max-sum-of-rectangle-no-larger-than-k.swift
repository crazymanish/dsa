class Solution {
    func maxSumSubmatrix(_ matrix: [[Int]], _ k: Int) -> Int {
        var result = Int.min
        let rows = matrix.count
        let columns = matrix[0].count
        
        
        for left in 0..<columns {
            var rowsSum = [Int](repeating: 0, count: rows)
            
            for right in left..<columns {
                for row in 0..<rows {
                    rowsSum[row] += matrix[row][right]
                }
                result = max(countSubarraysSmallerThenK(rowsSum), result)
            }
        }
        
        func countSubarraysSmallerThenK(_ array: [Int]) -> Int {
            var result = Int.min
        
            for i in 0..<array.count {
                var sum = 0
                for j in i..<array.count {
                    sum += array[j]
                    if sum > result && sum <= k {
                        result = sum
                    }
                }
            }
        
            return result
        }
        
        
        return result
    }
}