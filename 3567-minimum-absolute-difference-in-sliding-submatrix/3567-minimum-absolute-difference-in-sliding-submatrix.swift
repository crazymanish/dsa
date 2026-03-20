class Solution {

    /**
     Problem Summary:
     For every k x k submatrix, compute the minimum absolute difference
     between any two distinct elements.

     Strategy:
     - Use sliding window across columns for each row window.
     - Maintain:
        1. Frequency map
        2. Sorted unique values (via binary search)
     - Update window in O(k log k) per shift.

     Time Complexity:
     - O(n * m * k log k)

     Space Complexity:
     - O(k^2)
     */

    func minAbsDiff(_ grid: [[Int]], _ k: Int) -> [[Int]] {
        let rowCount = grid.count
        let colCount = grid[0].count

        var result = Array(
            repeating: Array(repeating: 0, count: colCount - k + 1),
            count: rowCount - k + 1
        )

        for topRow in 0..<(rowCount - k + 1) {

            var frequency: [Int: Int] = [:]
            var sortedValues: [Int] = []

            // Build first window
            for row in topRow..<(topRow + k) {
                for col in 0..<k {
                    add(grid[row][col], &frequency, &sortedValues)
                }
            }

            result[topRow][0] = computeMinDiff(sortedValues)

            // Slide horizontally
            for colStart in 1..<(colCount - k + 1) {

                let colToRemove = colStart - 1
                let colToAdd = colStart + k - 1

                for row in topRow..<(topRow + k) {
                    remove(grid[row][colToRemove], &frequency, &sortedValues)
                    add(grid[row][colToAdd], &frequency, &sortedValues)
                }

                result[topRow][colStart] = computeMinDiff(sortedValues)
            }
        }

        return result
    }

    // MARK: - Helpers

    private func computeMinDiff(_ sortedValues: [Int]) -> Int {
        guard sortedValues.count > 1 else { return 0 }

        var minDiff = Int.max

        for i in 0..<(sortedValues.count - 1) {
            minDiff = min(minDiff, sortedValues[i + 1] - sortedValues[i])
        }

        return minDiff
    }

    private func add(
        _ value: Int,
        _ frequency: inout [Int: Int],
        _ sortedValues: inout [Int]
    ) {
        let count = (frequency[value] ?? 0) + 1
        frequency[value] = count

        if count == 1 {
            insertSorted(value, &sortedValues)
        }
    }

    private func remove(
        _ value: Int,
        _ frequency: inout [Int: Int],
        _ sortedValues: inout [Int]
    ) {
        guard let count = frequency[value] else { return }

        if count == 1 {
            frequency.removeValue(forKey: value)
            removeSorted(value, &sortedValues)
        } else {
            frequency[value] = count - 1
        }
    }

    // MARK: - Binary Search Helpers

    private func insertSorted(_ value: Int, _ arr: inout [Int]) {
        var left = 0
        var right = arr.count

        while left < right {
            let mid = (left + right) / 2
            if arr[mid] < value {
                left = mid + 1
            } else {
                right = mid
            }
        }

        arr.insert(value, at: left)
    }

    private func removeSorted(_ value: Int, _ arr: inout [Int]) {
        var left = 0
        var right = arr.count - 1

        while left <= right {
            let mid = (left + right) / 2
            if arr[mid] == value {
                arr.remove(at: mid)
                return
            } else if arr[mid] < value {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
    }
}