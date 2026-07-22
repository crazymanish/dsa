/**
 Problem Summary:
 For each query, maximize the number of active sections (`1`s) after one trade.

 Strategy:
 Find all contiguous zero blocks. A trade merges two adjacent zero blocks,
 converting the sections between them into active sections. Binary search finds
 the query's boundary blocks, while a segment tree finds the best internal merge.

 Time Complexity:
 O(n + m log m + q log m)

 Space Complexity:
 O(m)
 */
class Solution {
    func maxActiveSectionsAfterTrade(_ s: String, _ queries: [[Int]]) -> [Int] {
        let characters = Array(s)
        let totalActiveSections = characters.filter { $0 == "1" }.count

        var zeroBlockLengths = [Int]()
        var zeroBlockStarts = [Int]()
        var zeroBlockEnds = [Int]()

        var index = 0

        // Record the length and inclusive boundaries of every zero block.
        while index < characters.count {
            let blockStart = index

            while index < characters.count &&
                  characters[index] == characters[blockStart] {
                index += 1
            }

            if characters[blockStart] == "0" {
                zeroBlockLengths.append(index - blockStart)
                zeroBlockStarts.append(blockStart)
                zeroBlockEnds.append(index - 1)
            }
        }

        let zeroBlockCount = zeroBlockLengths.count

        // A trade requires two distinct zero blocks.
        guard zeroBlockCount > 1 else {
            return Array(repeating: totalActiveSections, count: queries.count)
        }

        // Gain from merging each pair of adjacent zero blocks.
        let adjacentMergeGains = (0..<zeroBlockCount - 1).map {
            zeroBlockLengths[$0] + zeroBlockLengths[$0 + 1]
        }

        let segmentTree = SegmentTree(values: adjacentMergeGains)

        return queries.map { query in
            let queryStart = query[0]
            let queryEnd = query[1]

            // Locate the first and last zero blocks intersecting the query.
            let firstBlock = lowerBound(zeroBlockEnds, queryStart)
            let lastBlock = upperBound(zeroBlockStarts, queryEnd) - 1

            guard firstBlock < zeroBlockCount,
                  lastBlock >= 0,
                  firstBlock < lastBlock else {
                return totalActiveSections
            }

            // Boundary blocks may be only partially included in the query.
            let firstBlockLength =
                zeroBlockEnds[firstBlock] -
                max(zeroBlockStarts[firstBlock], queryStart) + 1

            let lastBlockLength =
                min(zeroBlockEnds[lastBlock], queryEnd) -
                zeroBlockStarts[lastBlock] + 1

            // Exactly two zero blocks are available for the trade.
            if firstBlock + 1 == lastBlock {
                return totalActiveSections +
                    firstBlockLength +
                    lastBlockLength
            }

            // Check both boundary merges and the best complete internal merge.
            let mergeFromFirstBlock =
                firstBlockLength + zeroBlockLengths[firstBlock + 1]

            let mergeIntoLastBlock =
                zeroBlockLengths[lastBlock - 1] + lastBlockLength

            let bestInternalMerge = segmentTree.query(
                firstBlock + 1,
                lastBlock - 2
            )

            return totalActiveSections + max(
                mergeFromFirstBlock,
                mergeIntoLastBlock,
                bestInternalMerge
            )
        }
    }

    private func lowerBound(_ values: [Int], _ target: Int) -> Int {
        var left = 0
        var right = values.count

        while left < right {
            let middle = (left + right) >> 1

            if values[middle] < target {
                left = middle + 1
            } else {
                right = middle
            }
        }

        return left
    }

    private func upperBound(_ values: [Int], _ target: Int) -> Int {
        var left = 0
        var right = values.count

        while left < right {
            let middle = (left + right) >> 1

            if values[middle] <= target {
                left = middle + 1
            } else {
                right = middle
            }
        }

        return left
    }
}

private final class SegmentTree {
    private let size: Int
    private var tree: [Int]

    init(values: [Int]) {
        size = values.count
        tree = Array(repeating: 0, count: values.count * 4)
        build(1, 0, values.count - 1, values)
    }

    private func build(_ node: Int, _ left: Int, _ right: Int, _ values: [Int]) {
        if left == right {
            tree[node] = values[left]
            return
        }

        let middle = (left + right) >> 1
        let leftChild = node << 1
        let rightChild = leftChild | 1

        build(leftChild, left, middle, values)
        build(rightChild, middle + 1, right, values)

        tree[node] = max(tree[leftChild], tree[rightChild])
    }

    func query(_ queryLeft: Int, _ queryRight: Int) -> Int {
        guard queryLeft <= queryRight else {
            return 0
        }

        return query(1, 0, size - 1, queryLeft, queryRight)
    }

    private func query(_ node: Int, _ left: Int, _ right: Int, _ queryLeft: Int, _ queryRight: Int) -> Int {
        if queryLeft <= left && right <= queryRight {
            return tree[node]
        }

        let middle = (left + right) >> 1
        let leftChild = node << 1
        let rightChild = leftChild | 1
        var maximum = 0

        if queryLeft <= middle {
            maximum = max(
                maximum,
                query(leftChild, left, middle, queryLeft, queryRight)
            )
        }

        if queryRight > middle {
            maximum = max(
                maximum,
                query(rightChild, middle + 1, right, queryLeft, queryRight)
            )
        }

        return maximum
    }
}