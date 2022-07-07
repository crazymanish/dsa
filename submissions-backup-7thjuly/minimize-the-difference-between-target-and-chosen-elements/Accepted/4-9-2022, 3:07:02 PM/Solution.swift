// https://leetcode.com/problems/minimize-the-difference-between-target-and-chosen-elements

class Solution {
    var matrixRowsCount = 0
    var matrixColumnsCount = 0
    
    func minimizeTheDifference(_ mat: [[Int]], _ target: Int) -> Int {
        matrixRowsCount = mat.count
        matrixColumnsCount = mat[0].count
        var dpMemorizationCache: [[Int]] = Array(repeating: Array(repeating: -1, count: (70 * 70 + 1)), count: 70 + 1)

        return minimizeTheDifference(mat, 0, 0, target, &dpMemorizationCache)
    }

    private func minimizeTheDifference(_ mat: [[Int]], _ currentRow: Int, _ currentSum: Int, _ target: Int, _ cache: inout [[Int]]) -> Int {
        if currentRow >= matrixRowsCount { return abs(currentSum - target) }

        // Check cache if we already have result or not
        if cache[currentRow][currentSum] != -1  { return cache[currentRow][currentSum] }

        var minimumDifference = Int.max
        
        for column in 0..<matrixColumnsCount {
            let currentValue = mat[currentRow][column]
            let currentDifference = minimizeTheDifference(mat, currentRow+1, currentSum+currentValue, target, &cache)
            
            minimumDifference = min(minimumDifference, currentDifference)
        }
        
        // Save result into cache
        cache[currentRow][currentSum] = minimumDifference

        return minimumDifference
    }
}