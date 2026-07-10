class Solution {
    /**
     Problem Summary:
     Given node values and multiple queries, find the minimum number of jumps
     required to travel between two nodes. A jump is allowed when the difference
     between the two node values is at most `maxDiff`.

     Strategy:
     1. Sort node indices by their values and record each node's position in the
        sorted order.
     2. Use a sliding window to determine the farthest sorted position reachable
        from every position in one jump.
     3. Build a binary lifting table where `jumpTable[level][position]` stores
        the farthest position reachable using up to `2^level` jumps.
     4. For each query, greedily apply the largest valid jumps that remain before
        the destination, then make one final jump if possible.

     Time Complexity:
     - Preprocessing: O(n log n)
     - Each query: O(log n)
     - Total: O(n log n + queries.count * log n)

     Space Complexity:
     O(n log n)
     */
    func pathExistenceQueries(
        _ n: Int,
        _ nums: [Int],
        _ maxDiff: Int,
        _ queries: [[Int]]
    ) -> [Int] {
        // Sort node indices by value without losing their original identities.
        let indicesSortedByValue = (0..<n).sorted {
            nums[$0] < nums[$1]
        }

        // `sortedPosition[node]` gives the node's position in sorted-value order.
        var sortedPosition = [Int](repeating: 0, count: n)

        // Store values directly in sorted order for efficient range calculations.
        var sortedValues = [Int](repeating: 0, count: n)

        for (position, originalIndex) in indicesSortedByValue.enumerated() {
            sortedPosition[originalIndex] = position
            sortedValues[position] = nums[originalIndex]
        }

        // `farthestReachable[position]` is the farthest sorted position that can
        // be reached from `position` in one jump.
        var farthestReachable = [Int](repeating: 0, count: n)
        var rightBoundary = 0

        for leftBoundary in 0..<n {
            // The right boundary must never move behind the current position.
            rightBoundary = max(rightBoundary, leftBoundary)

            // Expand while the value difference remains within the allowed limit.
            while rightBoundary + 1 < n,
                  sortedValues[rightBoundary + 1] - sortedValues[leftBoundary] <= maxDiff {
                rightBoundary += 1
            }

            farthestReachable[leftBoundary] = rightBoundary
        }

        // Determine how many binary lifting levels are required.
        var levelCount = 1
        while (1 << levelCount) < n {
            levelCount += 1
        }

        // `jumpTable[level][position]` stores the farthest position reachable
        // after applying up to 2^level jumps.
        var jumpTable = Array(
            repeating: [Int](repeating: 0, count: n),
            count: levelCount
        )

        jumpTable[0] = farthestReachable

        for level in 1..<levelCount {
            for position in 0..<n {
                let intermediatePosition = jumpTable[level - 1][position]
                jumpTable[level][position] = jumpTable[level - 1][intermediatePosition]
            }
        }

        return queries.map { query in
            let startNode = query[0]
            let destinationNode = query[1]

            // No jumps are needed when both endpoints are the same node.
            if startNode == destinationNode {
                return 0
            }

            var startPosition = sortedPosition[startNode]
            var destinationPosition = sortedPosition[destinationNode]

            // Movement is symmetric, so process every query from left to right
            // in sorted-value order.
            if startPosition > destinationPosition {
                swap(&startPosition, &destinationPosition)
            }

            // The destination is directly reachable in one jump.
            if farthestReachable[startPosition] >= destinationPosition {
                return 1
            }

            var currentPosition = startPosition
            var minimumJumpCount = 0

            // Take the largest jump that still lands strictly before the target.
            // This preserves room for the final jump to the destination.
            for level in (0..<levelCount).reversed() {
                let nextPosition = jumpTable[level][currentPosition]

                if nextPosition < destinationPosition {
                    // No progress means the destination cannot be reached.
                    if nextPosition == currentPosition {
                        return -1
                    }

                    currentPosition = nextPosition
                    minimumJumpCount += 1 << level
                }
            }

            // Make the final jump if the destination is now reachable.
            return farthestReachable[currentPosition] >= destinationPosition
                ? minimumJumpCount + 1
                : -1
        }
    }
}