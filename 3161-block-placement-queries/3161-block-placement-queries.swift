final class Solution {
    /**
     Problem Summary:
     Process two query types:
     - Type 1: add an obstacle at position x.
     - Type 2: check whether a block of size sz can fit inside [0, x]
       without crossing an obstacle.

     Strategy:
     Process queries in reverse.
     - First build the final obstacle state after all forward additions.
     - Use a Fenwick tree to maintain active obstacle positions.
     - Use a max segment tree to store each gap length at its right obstacle.
     - In reverse, adding an obstacle becomes removing it.
     - When removing an obstacle, merge the gap between its left and right neighbors.

     Time Complexity:
     O(Q log M), where Q is the number of queries and M = 50,000.

     Space Complexity:
     O(Q + M), for the collected obstacles, Fenwick tree, and segment tree.
     */
    private let maxCoordinate = 50_000

    func getResults(_ queries: [[Int]]) -> [Bool] {
        let maxGapTree = MaxSegmentTree(maxCoordinate: maxCoordinate)
        let obstacleTree = FenwickTree(size: maxCoordinate + 1)

        var obstacleSet: Set<Int> = [0]

        // Build the final obstacle set after all forward type-1 additions.
        for query in queries where query[0] == 1 {
            obstacleSet.insert(query[1])
        }

        let obstacles = obstacleSet.sorted()

        // Mark all final obstacles as active.
        for obstacle in obstacles {
            obstacleTree.add(at: obstacle, delta: 1)
        }

        // Store every completed gap at its right obstacle.
        for index in 1..<obstacles.count {
            let leftObstacle = obstacles[index - 1]
            let rightObstacle = obstacles[index]
            let gapLength = rightObstacle - leftObstacle

            maxGapTree.update(at: rightObstacle, value: gapLength)
        }

        var answers: [Bool] = []

        // Process queries backward so obstacle additions become removals.
        for query in queries.reversed() {
            if query[0] == 2 {
                let targetPosition = query[1]
                let requiredSize = query[2]

                // Find the nearest active obstacle <= targetPosition.
                let previousObstacleRank = obstacleTree.prefixSum(upTo: targetPosition)
                let previousObstacle = obstacleTree.coordinate(withRank: previousObstacleRank)

                // Best completed gap ending before or at previousObstacle.
                let bestCompletedGap = maxGapTree.query(left: 0, right: previousObstacle)

                // Also consider the unfinished gap from previousObstacle to targetPosition.
                let partialGap = targetPosition - previousObstacle
                let bestAvailableGap = max(bestCompletedGap, partialGap)

                answers.append(bestAvailableGap >= requiredSize)
            } else {
                let removedObstacle = query[1]

                // Locate neighbors by rank before removing this obstacle.
                let removedRank = obstacleTree.prefixSum(upTo: removedObstacle)
                let activeObstacleCount = obstacleTree.prefixSum(upTo: maxCoordinate)
                let leftObstacle = obstacleTree.coordinate(withRank: removedRank - 1)

                // Remove the completed gap ending at this obstacle.
                maxGapTree.update(at: removedObstacle, value: 0)

                // If a right neighbor exists, merge the left and right gaps.
                if removedRank < activeObstacleCount {
                    let rightObstacle = obstacleTree.coordinate(withRank: removedRank + 1)
                    let mergedGapLength = rightObstacle - leftObstacle

                    maxGapTree.update(at: rightObstacle, value: mergedGapLength)
                }

                // Finally deactivate the obstacle.
                obstacleTree.add(at: removedObstacle, delta: -1)
            }
        }

        return answers.reversed()
    }
}

final class MaxSegmentTree {
    /**
     Stores maximum gap lengths by coordinate.

     Each leaf represents one coordinate.
     If a gap ends at coordinate x, that gap length is stored at x.
     Range queries return the largest gap ending inside the requested range.

     Update:
     O(log M)

     Query:
     O(log M)

     Space:
     O(M)
     */
    private let size: Int
    private var tree: [Int]

    init(maxCoordinate: Int) {
        var powerOfTwo = 1

        while powerOfTwo <= maxCoordinate {
            powerOfTwo *= 2
        }

        self.size = powerOfTwo
        self.tree = Array(repeating: 0, count: size * 2)
    }

    func update(at index: Int, value: Int) {
        var treeIndex = index + size
        tree[treeIndex] = value

        while treeIndex > 1 {
            treeIndex /= 2
            tree[treeIndex] = max(tree[treeIndex * 2], tree[treeIndex * 2 + 1])
        }
    }

    func query(left: Int, right: Int) -> Int {
        guard left <= right else { return 0 }

        var leftIndex = left + size
        var rightIndex = right + size
        var bestValue = 0

        while leftIndex <= rightIndex {
            if leftIndex % 2 == 1 {
                bestValue = max(bestValue, tree[leftIndex])
                leftIndex += 1
            }

            if rightIndex % 2 == 0 {
                bestValue = max(bestValue, tree[rightIndex])
                rightIndex -= 1
            }

            leftIndex /= 2
            rightIndex /= 2
        }

        return bestValue
    }
}

final class FenwickTree {
    /**
     Maintains active obstacle positions.

     Each coordinate stores either:
     - 1 if an obstacle is currently active.
     - 0 if there is no active obstacle.

     Supports:
     - Prefix count queries.
     - Activating/deactivating obstacles.
     - Finding the coordinate of the k-th active obstacle.

     Update:
     O(log M)

     Prefix Sum:
     O(log M)

     Rank Lookup:
     O(log M)

     Space:
     O(M)
     */
    private var tree: [Int]

    init(size: Int) {
        self.tree = Array(repeating: 0, count: size + 1)
    }

    func add(at position: Int, delta: Int) {
        var index = position + 1

        while index < tree.count {
            tree[index] += delta
            index += index & -index
        }
    }

    func prefixSum(upTo position: Int) -> Int {
        var index = position + 1
        var sum = 0

        while index > 0 {
            sum += tree[index]
            index -= index & -index
        }

        return sum
    }

    func coordinate(withRank rank: Int) -> Int {
        var index = 0
        var bitMask = 1

        while bitMask < tree.count {
            bitMask <<= 1
        }

        var remainingRank = rank

        while bitMask > 0 {
            let nextIndex = index + bitMask

            if nextIndex < tree.count && tree[nextIndex] < remainingRank {
                index = nextIndex
                remainingRank -= tree[nextIndex]
            }

            bitMask >>= 1
        }

        return index
    }
}