// https://leetcode.com/problems/find-triangular-sum-of-an-array

class Solution {
    func triangularSum(_ nums: [Int]) -> Int {
        var outputRow = nums
        
        while outputRow.count > 1 {
            var currentRow: [Int] = []
            
            for index in 0..<outputRow.count-1 {
                let currentValue = outputRow[index] + outputRow[index+1]
                currentRow.append(currentValue % 10)
            }
            
            outputRow = currentRow
        }
        
        return outputRow[0]
    }
}