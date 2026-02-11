/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(n log n)
///     - Each element causes at most two segment tree updates (O(log n))
///     - Each query for leftmost zero is O(log n)
///
/// Space Complexity:
///   • O(n)
///     - Segment tree arrays of size ~4n
///     - Hash map for last occurrences
///
/// Problem Summary:
///   Find the longest subarray where the number of distinct even values
///   equals the number of distinct odd values.
///
/// Strategy:
///   - Maintain a prefix balance using a segment tree.
///   - Even contributes +1, odd contributes -1.
///   - Track last occurrence of each value to avoid double counting.
///   - The longest balanced subarray corresponds to a prefix difference of 0.
/// ---------------------------------------------------------------------------

final class RangeBalanceSegmentTree {
    private let size: Int
    private var minValue: [Int]
    private var maxValue: [Int]
    private var lazyAdd: [Int]

    init(_ size: Int) {
        self.size = size
        self.minValue = Array(repeating: 0, count: 4 * size)
        self.maxValue = Array(repeating: 0, count: 4 * size)
        self.lazyAdd = Array(repeating: 0, count: 4 * size)
    }

    /// Push lazy value to children
    private func propagate(_ node: Int, _ left: Int, _ right: Int) {
        let pending = lazyAdd[node]
        if pending != 0 {
            minValue[node] += pending
            maxValue[node] += pending

            if left != right {
                lazyAdd[node * 2] += pending
                lazyAdd[node * 2 + 1] += pending
            }
            lazyAdd[node] = 0
        }
    }

    /// Range increment update
    func addToRange(
        _ node: Int,
        _ left: Int,
        _ right: Int,
        _ queryLeft: Int,
        _ queryRight: Int,
        _ value: Int
    ) {
        propagate(node, left, right)

        if left > right || left > queryRight || right < queryLeft {
            return
        }

        if queryLeft <= left && right <= queryRight {
            lazyAdd[node] += value
            propagate(node, left, right)
            return
        }

        let mid = (left + right) >> 1
        addToRange(node * 2, left, mid, queryLeft, queryRight, value)
        addToRange(node * 2 + 1, mid + 1, right, queryLeft, queryRight, value)

        minValue[node] = min(minValue[node * 2], minValue[node * 2 + 1])
        maxValue[node] = max(maxValue[node * 2], maxValue[node * 2 + 1])
    }

    /// Find leftmost index where prefix balance == 0
    func findLeftmostZero(_ node: Int, _ left: Int, _ right: Int) -> Int {
        propagate(node, left, right)

        // No zero exists in this segment
        if minValue[node] > 0 || maxValue[node] < 0 {
            return -1
        }

        if left == right {
            return minValue[node] == 0 ? left : -1
        }

        let mid = (left + right) >> 1
        let leftResult = findLeftmostZero(node * 2, left, mid)
        if leftResult != -1 { return leftResult }

        return findLeftmostZero(node * 2 + 1, mid + 1, right)
    }
}

class Solution {
    func longestBalanced(_ nums: [Int]) -> Int {
        let n = nums.count

        // Tracks last occurrence of each value
        var lastOccurrence = [Int: Int]()

        let segmentTree = RangeBalanceSegmentTree(n)
        var longestLength = 0

        for rightIndex in 0..<n {
            let value = nums[rightIndex]

            // Even contributes +1, odd contributes -1
            let balanceDelta = (value & 1 == 0) ? 1 : -1

            // Remove previous contribution of same value
            if let previousIndex = lastOccurrence[value] {
                segmentTree.addToRange(
                    1, 0, n - 1,
                    0, previousIndex,
                    -balanceDelta
                )
            }

            // Add current contribution
            segmentTree.addToRange(
                1, 0, n - 1,
                0, rightIndex,
                balanceDelta
            )

            lastOccurrence[value] = rightIndex

            // Find earliest prefix with balance 0
            let leftIndex = segmentTree.findLeftmostZero(1, 0, n - 1)

            if leftIndex != -1 && leftIndex <= rightIndex {
                longestLength = max(longestLength, rightIndex - leftIndex + 1)
            }
        }

        return longestLength
    }
}
