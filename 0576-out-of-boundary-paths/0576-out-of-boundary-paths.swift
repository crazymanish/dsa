class Solution {
    func findPaths(_ m: Int, _ n: Int, _ maxMove: Int, _ startRow: Int, _ startColumn: Int) -> Int {
        if maxMove == 0 { return  0 }
        
        let mode: Int = Int(1e9 + 7)
        var moves = Array(repeating: Array(repeating: 0, count: n), count: m)

        for _ in 1...maxMove {
            var dp = Array(repeating: Array(repeating: 0, count: n), count: m)
            
            for rowIndex in 0..<m {
                for columnIndex in 0..<n {
                    let leftborderM = rowIndex-1 >= 0 ? moves[rowIndex-1][columnIndex] : 1
                    let leftborderN = columnIndex-1 >= 0 ? moves[rowIndex][columnIndex-1] : 1
                    let rightborderM = rowIndex+1 < m ? moves[rowIndex+1][columnIndex] : 1
                    let rightborderN = columnIndex+1 < n ? moves[rowIndex][columnIndex+1] : 1

                    dp[rowIndex][columnIndex] = (leftborderM + leftborderN + rightborderM + rightborderN) % mode
                }
            }
            
            moves = dp
        }

        return moves[startRow][startColumn]
    }
}