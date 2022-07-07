// https://leetcode.com/problems/matrix-diagonal-sum

class Solution {
    func diagonalSum(_ mat: [[Int]]) -> Int {
        let matCount = mat.count
        var output = 0
        
        for i in 0..<matCount {
            for j in 0..<matCount {
                if i == j {
                    output += mat[i][j]
                }
                
                if i+1 == matCount && j == 0 {
                    output += mat[i][j]
                    output += mat[j][i]   
                }
            }
        }
        
        return output
    }
}