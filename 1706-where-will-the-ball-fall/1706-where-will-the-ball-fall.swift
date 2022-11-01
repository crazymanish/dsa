class Solution {
    func findBall(_ grid: [[Int]]) -> [Int] {
        guard !grid.isEmpty else { return [] }
        
        let columns = grid[0].count
        var result: [Int] = []
        var dp: [[Int]] = .init(repeating: .init(repeating: -1, count: columns), count: grid.count + 1)
        
        for row in stride(from: dp.count - 1, to: -1, by: -1) {
            for column in stride(from: 0, to: columns, by: 1) {
                if row == dp.count - 1 {
                    dp[row][column] = column
                    continue
                }
                
                let nextColumn = column + grid[row][column]
                if let value = dp[row + 1][safe: nextColumn], grid[row][safe: nextColumn] == grid[row][column] {
                    dp[row][column] = value
                }
                
                if row == 0 {
                    result.append(dp[row][column])
                }
            }
        }
        
        return result
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}