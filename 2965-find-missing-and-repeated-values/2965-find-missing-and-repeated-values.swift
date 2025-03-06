class Solution {
    func findMissingAndRepeatedValues(_ grid: [[Int]]) -> [Int] {
        var seen = Set<Int>()
        var duplicate = 0
        var missing = 0
        let n = grid.count

        // Find duplicate and missing numbers
        for row in grid {
            for num in row {
                if seen.contains(num) {
                    duplicate = num
                } else {
                    seen.insert(num)
                }
            }
        }

        // Calculate the expected sum of numbers from 1 to n^2
        let expectedSum = (n * n * (n * n + 1)) / 2
        var actualSum = 0

        // Calculate the actual sum of numbers in the grid
        for row in grid {
            actualSum += row.reduce(0, +)
        }

        // Calculate the missing number
        missing = expectedSum - actualSum + duplicate

        return [duplicate, missing]
    }
}