class Solution {
    func matrixScore(_ grid: [[Int]]) -> Int {
        let m = grid.count
        let n = grid[0].count

        var answer = (1 << (n - 1)) * m

        for j in 1..<n {
            var sameBitsCount = 0
            for i in 0..<m where grid[i][j] == grid[i][0] {
                sameBitsCount += 1
            }

            sameBitsCount = max(sameBitsCount, m - sameBitsCount)
            answer += ( 1 << (n - j - 1)) * sameBitsCount
        }
        return answer
    }
}