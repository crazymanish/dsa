class Solution {
    func rotateTheBox(_ box: [[Character]]) -> [[Character]] {
        var result: [[Character]] = Array(repeating: Array(repeating: ".", count: box.count), count: box.first?.count ?? 0)
        let m = box.count - 1
        
        for (i, row) in box.enumerated() {
            for j in stride(from: (row.count-1), through: 0, by: -1) {
                result[j][m-i] = row[j]
                applyGravityForIndex(j, m-i)
            }
        }
        
        func applyGravityForIndex(_ i: Int, _ j: Int) {
            if  i > result.count - 1 || result[i][j] == "*" || result[i][j] == "." { return }

            if i+1 < result.count, result[i+1][j] == "." {
                result[i+1][j] = "#"
                result[i][j] = "."
                applyGravityForIndex(i+1, j)
            }
 
        }
       
        return result
    }
}