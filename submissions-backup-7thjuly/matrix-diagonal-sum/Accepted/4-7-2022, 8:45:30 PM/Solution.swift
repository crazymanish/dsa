// https://leetcode.com/problems/matrix-diagonal-sum

class Solution {
    func diagonalSum(_ mat: [[Int]]) -> Int {
        let matCount = mat.count
        var output = 0
        
        for index in 0..<matCount {
            output += mat[index][index] // (0, 0) (1, 1) (2, 2)...
            output += mat[index][matCount-index-1] // (0, 2) (1, 1) (2, 0)
        }
        
        // Reduce the overlapping element
        if matCount % 2 != 0 {
            let index = matCount / 2
            output -= mat[index][index] // (1, 1)
        }
        
        return output
    }
}