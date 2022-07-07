// https://leetcode.com/problems/matrix-diagonal-sum

class Solution {
    func diagonalSum(_ mat: [[Int]]) -> Int {
        let matCount = mat.count
        var output = 0
        
        for i in 0..<matCount {
            for j in 0..<matCount {
                if i == j { output += mat[i][j] }
            }
            
            for k in (0..<matCount).reversed() {
                if i == k { output += mat[i][k] }
            }
        }
        
        // Reduce the overlapping element
        if matCount % 2 != 0 {
            let index = matCount / 2
            output -= mat[index][index]
        }
        
        return output
    }
}