// https://leetcode.com/problems/maximum-length-of-repeated-subarray

class Solution {
    func findLength(_ nums1: [Int], _ nums2: [Int]) -> Int {
        let rowsCount = nums1.count
        let columnsCount = nums2.count
        
        var dpCache = Array(repeating: Array(repeating: 0, count: columnsCount), count: rowsCount)
        
        for row in 0..<rowsCount {
            for column in 0..<columnsCount {
                var previousLength = 0
                
                if row > 0 && column > 0 {
                    previousLength = dpCache[row-1][column-1]
                }
                
                dpCache[row][column] = previousLength
                
                if nums1[row] == nums2[column] {
                    dpCache[row][column] += 1
                }
            }
        }
        
        // We have answer in last row (Max element in last row)
        let lastRow = dpCache[rowsCount-1]
        var output = 0
        for element in lastRow { output = max(output, element) }
        
        return output
    }
}