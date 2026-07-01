class Solution {
    /**
     Problem Summary:
     Find a path from the top-left cell to the bottom-right cell such that the minimum
     distance from any cell on the path to the nearest thief is as large as possible.

     Strategy:
     1. Run multi-source BFS from all thief cells to compute each cell's distance
        from the nearest thief.
     2. Use a max-priority search, similar to Dijkstra's algorithm, where each path's
        score is the minimum thief-distance seen along that path.
     3. Always explore the currently safest path first.

     Time Complexity:
     O(n^2 log(n^2)) because each cell may be inserted into the heap.

     Space Complexity:
     O(n^2) for distance, safeness tracking, BFS queue, and heap.
     */
    func maximumSafenessFactor(_ grid: [[Int]]) -> Int {
        let gridSize = grid.count
        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]

        var nearestThiefDistance = Array(
            repeating: Array(repeating: Int.max, count: gridSize),
            count: gridSize
        )

        // Step 1: Start BFS from every thief cell at once.
        var bfsQueue: [(row: Int, col: Int)] = []

        for row in 0..<gridSize {
            for col in 0..<gridSize {
                if grid[row][col] == 1 {
                    nearestThiefDistance[row][col] = 0
                    bfsQueue.append((row, col))
                }
            }
        }

        // Step 2: Compute the shortest distance from each cell to any thief.
        var queueIndex = 0

        while queueIndex < bfsQueue.count {
            let currentCell = bfsQueue[queueIndex]
            queueIndex += 1

            for (rowOffset, colOffset) in directions {
                let nextRow = currentCell.row + rowOffset
                let nextCol = currentCell.col + colOffset

                guard nextRow >= 0,
                      nextRow < gridSize,
                      nextCol >= 0,
                      nextCol < gridSize
                else {
                    continue
                }

                let nextDistance = nearestThiefDistance[currentCell.row][currentCell.col] + 1

                if nextDistance < nearestThiefDistance[nextRow][nextCol] {
                    nearestThiefDistance[nextRow][nextCol] = nextDistance
                    bfsQueue.append((nextRow, nextCol))
                }
            }
        }

        // Step 3: Search for the path with the maximum possible minimum safeness.
        var bestSafeness = Array(
            repeating: Array(repeating: Int.min, count: gridSize),
            count: gridSize
        )

        var maxHeap: [(safeness: Int, row: Int, col: Int)] = [
            (nearestThiefDistance[0][0], 0, 0)
        ]

        bestSafeness[0][0] = nearestThiefDistance[0][0]

        while !maxHeap.isEmpty {
            // Keeps the safest available path at the front.
            // This preserves your original approach, but a real heap would be faster.
            maxHeap.sort { $0.safeness > $1.safeness }

            let currentCell = maxHeap.removeFirst()

            // Once we reach the destination from the safest available path,
            // this is the best possible answer.
            if currentCell.row == gridSize - 1 && currentCell.col == gridSize - 1 {
                return currentCell.safeness
            }

            for (rowOffset, colOffset) in directions {
                let nextRow = currentCell.row + rowOffset
                let nextCol = currentCell.col + colOffset

                guard nextRow >= 0,
                      nextRow < gridSize,
                      nextCol >= 0,
                      nextCol < gridSize
                else {
                    continue
                }

                // Path safeness is limited by the weakest cell on the path.
                let nextSafeness = min(
                    currentCell.safeness,
                    nearestThiefDistance[nextRow][nextCol]
                )

                if nextSafeness > bestSafeness[nextRow][nextCol] {
                    bestSafeness[nextRow][nextCol] = nextSafeness
                    maxHeap.append((nextSafeness, nextRow, nextCol))
                }
            }
        }

        return bestSafeness[gridSize - 1][gridSize - 1]
    }
}