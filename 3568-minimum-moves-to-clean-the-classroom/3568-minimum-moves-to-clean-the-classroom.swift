class Solution {

    /**
     Problem Summary:
     Find the minimum number of moves needed to collect all litter (`L`) in the
     classroom. Moving to an adjacent cell costs one unit of energy, while a
     recharge cell (`R`) restores energy to the initial maximum. Obstacles (`X`)
     cannot be crossed.

     Strategy:
     - Use BFS because every movement has the same cost: one move.
     - Assign each litter cell a bit in a bitmask.
     - A BFS state consists of:
       `(row, column, collectedMask, remainingEnergy)`.
     - For each `(row, column, collectedMask)`, keep only the greatest remaining
       energy seen so far. Reaching the same state with less or equal energy
       cannot lead to a better result.
     - Stop as soon as BFS collects every litter, since BFS explores states in
       increasing number of moves.

     Time Complexity:
     O(rows * columns * 2^L * energy),
     where L is the number of litter cells.

     Space Complexity:
     O(rows * columns * 2^L + BFS states).
     */
    func minMoves(_ classroom: [String], _ energy: Int) -> Int {

        struct State {
            let row: Int
            let column: Int
            let collectedMask: UInt16
            let remainingEnergy: Int
            let moves: Int
        }

        var grid = classroom.map(Array.init)
        let rowCount = grid.count
        let columnCount = grid[0].count

        var startState: State?
        var litterCount = 0
        var allLitterMask: UInt16 = 0

        // Assign each litter cell a unique bit position.
        // For example, with 3 litter cells:
        // litter 0 -> 001
        // litter 1 -> 010
        // litter 2 -> 100
        // target   -> 111
        for row in 0..<rowCount {
            for column in 0..<columnCount {
                let cell = grid[row][column]

                if cell == "S" {
                    startState = State(
                        row: row,
                        column: column,
                        collectedMask: 0,
                        remainingEnergy: energy,
                        moves: 0
                    )
                } else if cell == "L" {
                    // Store the litter index directly in the grid so we can
                    // identify which bit to set when BFS reaches this cell.
                    grid[row][column] = Character(
                        UnicodeScalar(48 + litterCount)!
                    )

                    allLitterMask |= UInt16(1) << UInt16(litterCount)
                    litterCount += 1
                }
            }
        }

        // Nothing needs to be collected.
        if litterCount == 0 {
            return 0
        }

        guard let startState else {
            return -1
        }

        // For each position + collected-litter mask, store the maximum energy
        // we've had when reaching that state.
        //
        // If we reach the same state later with less or equal energy, there is
        // no reason to explore it again.
        let maskCount = 1 << litterCount

        var bestEnergy = Array(
            repeating: Array(
                repeating: Array(repeating: -1, count: maskCount),
                count: columnCount
            ),
            count: rowCount
        )

        bestEnergy[startState.row][startState.column][0] = energy

        let directions = [
            (row: 1, column: 0),
            (row: -1, column: 0),
            (row: 0, column: 1),
            (row: 0, column: -1)
        ]

        // Use an index instead of removeFirst() so queue operations stay O(1).
        var queue = [startState]
        var queueIndex = 0

        while queueIndex < queue.count {
            let currentState = queue[queueIndex]
            queueIndex += 1

            // We cannot leave the current cell without energy.
            if currentState.remainingEnergy <= 0 {
                continue
            }

            for direction in directions {
                let nextRow = currentState.row + direction.row
                let nextColumn = currentState.column + direction.column

                guard
                    nextRow >= 0,
                    nextRow < rowCount,
                    nextColumn >= 0,
                    nextColumn < columnCount
                else {
                    continue
                }

                let nextCell = grid[nextRow][nextColumn]

                // Obstacles cannot be entered.
                if nextCell == "X" {
                    continue
                }

                // Moving consumes one energy. Entering a recharge cell restores
                // energy to the original maximum.
                let nextEnergy = nextCell == "R"
                    ? energy
                    : currentState.remainingEnergy - 1

                var nextMask = currentState.collectedMask

                if let litterIndex = nextCell.wholeNumberValue {
                    // OR is idempotent, so revisiting an already collected
                    // litter leaves the mask unchanged.
                    nextMask |= UInt16(1) << UInt16(litterIndex)

                    // BFS guarantees that this is the minimum number of moves.
                    if nextMask == allLitterMask {
                        return currentState.moves + 1
                    }
                }

                let previousBestEnergy =
                    bestEnergy[nextRow][nextColumn][Int(nextMask)]

                if nextEnergy <= previousBestEnergy {
                    continue
                }

                bestEnergy[nextRow][nextColumn][Int(nextMask)] = nextEnergy

                queue.append(
                    State(
                        row: nextRow,
                        column: nextColumn,
                        collectedMask: nextMask,
                        remainingEnergy: nextEnergy,
                        moves: currentState.moves + 1
                    )
                )
            }
        }

        return -1
    }
}