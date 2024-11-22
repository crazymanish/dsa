class Solution {
    func maxEqualRowsAfterFlips(_ matrix: [[Int]]) -> Int {
        var freqs = [[Int]: Int]()

        for row in matrix {
            let normalizedRow = row[0] == 0 ? row : row.map { 1 - $0 }
            freqs[normalizedRow, default: 0] += 1
        }

        return freqs.values.max() ?? 0
    }
}