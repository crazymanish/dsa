class Solution {
    func generateMatrix(_ n: Int) -> [[Int]] {
        let defaultResultRow: [Int] = Array(repeating: -1, count: n)
        var result: [[Int]] = Array(repeating: defaultResultRow, count: n)

        var count = 1

        var left = 0
        var top = 0
        var right = n - 1
        var bottom = n - 1

        while count <= n*n {
            for column in stride(from: left, through: right, by: 1) {
                result[top][column] = count
                count += 1
            }

            for row in stride(from: top + 1, through: bottom, by: 1) {
                result[row][right] = count
                count += 1
            }

            for column in stride(from: right - 1, through: left, by: -1) {
                result[bottom][column] = count
                count += 1
            }

            for row in stride(from: bottom - 1, through: top + 1, by: -1) {
                result[row][left] = count
                count += 1
            }

            left += 1
            top += 1
            right -= 1
            bottom -= 1
        }

        return result
    }
}