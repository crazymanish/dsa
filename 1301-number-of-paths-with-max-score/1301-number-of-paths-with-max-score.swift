class Solution {
    /**
     Problem Summary:
     Given a square board where:
     - "E" is the start at the top-left
     - "S" is the end at the bottom-right
     - "X" represents blocked cells
     - Digits represent collectible scores

     Return [maximumScore, numberOfPaths], where numberOfPaths is the count of paths
     that achieve the maximum score.

     Strategy:
     Use DFS with memoization starting from "S" and moving backwards toward "E".
     From each cell, we check the three possible previous cells:
     - Left
     - Up
     - Upper-left diagonal

     Each DFS result represents:
     - maximum score from "E" to the current cell
     - number of paths that achieve that score

     Time Complexity:
     O(n²), where n is the board size. Each cell is computed once.

     Space Complexity:
     O(n²), for memoization and recursion stack in the worst case.
     */
    func pathsWithMaxScore(_ board: [String]) -> [Int] {
        let boardSize = board.count
        let modulo = 1_000_000_007
        let grid = board.map { Array($0) }

        // memo[row][column] stores the best result for that cell.
        // nil means the cell has not been computed yet.
        var memo = Array(
            repeating: Array<Result?>(repeating: nil, count: boardSize),
            count: boardSize
        )

        let previousDirections = [
            (0, -1),    // From left
            (-1, 0),    // From above
            (-1, -1)    // From upper-left diagonal
        ]

        func isInsideBoard(_ row: Int, _ column: Int) -> Bool {
            row >= 0 && row < boardSize && column >= 0 && column < boardSize
        }

        func dfs(_ row: Int, _ column: Int) -> Result {
            let currentCell = grid[row][column]

            // Reaching "E" means we found one valid path with score 0.
            if currentCell == "E" {
                return Result(maximumScore: 0, pathCount: 1)
            }

            // Blocked cells are unreachable.
            if currentCell == "X" {
                return Result(maximumScore: -1, pathCount: 0)
            }

            // Return the cached result if this cell was already computed.
            if let cachedResult = memo[row][column] {
                return cachedResult
            }

            // "S" contributes 0 score. Digit cells contribute their numeric value.
            let currentScore = Int(String(currentCell)) ?? 0

            var bestScore = -1
            var bestPathCount = 0

            for (rowOffset, columnOffset) in previousDirections {
                let previousRow = row + rowOffset
                let previousColumn = column + columnOffset

                // Ignore cells outside the board.
                guard isInsideBoard(previousRow, previousColumn) else {
                    continue
                }

                let previousResult = dfs(previousRow, previousColumn)

                // Skip cells that cannot be reached from "E".
                if previousResult.maximumScore == -1 {
                    continue
                }

                let totalScore = currentScore + previousResult.maximumScore

                if totalScore > bestScore {
                    // Found a better score, so replace both score and path count.
                    bestScore = totalScore
                    bestPathCount = previousResult.pathCount
                } else if totalScore == bestScore {
                    // Found another path with the same best score.
                    bestPathCount = (bestPathCount + previousResult.pathCount) % modulo
                }
            }

            let result = Result(maximumScore: bestScore, pathCount: bestPathCount)
            memo[row][column] = result

            return result
        }

        let finalResult = dfs(boardSize - 1, boardSize - 1)

        // If "S" is unreachable from "E", return [0, 0].
        if finalResult.maximumScore == -1 {
            return [0, 0]
        }

        return [
            finalResult.maximumScore % modulo,
            finalResult.pathCount % modulo
        ]
    }
}

extension Solution {
    struct Result {
        let maximumScore: Int
        let pathCount: Int
    }
}