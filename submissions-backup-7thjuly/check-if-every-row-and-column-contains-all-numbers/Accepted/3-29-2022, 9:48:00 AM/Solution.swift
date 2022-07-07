// https://leetcode.com/problems/check-if-every-row-and-column-contains-all-numbers

class Solution {
    func checkValid(_ matrix: [[Int]]) -> Bool {
        let n = matrix.count
        var isValid = true
        
        for i in 0..<n {
            var rowHashMap: [Int : Bool] = [:]
            var columnHashMap: [Int : Bool] = [:]
            
            for j in 0..<n {
                 rowHashMap[matrix[i][j]] = true
                 columnHashMap[matrix[j][i]] = true
            }
            
            for key in 1...n {
                if rowHashMap[key] == nil || columnHashMap[key] == nil {
                    isValid = false
                    break
                }
            }
            
            if isValid == false { break }
            
        }
        
        return isValid
    }
}