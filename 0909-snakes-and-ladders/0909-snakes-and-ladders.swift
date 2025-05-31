// Time Complexity: O(N_squares), where N_squares is the total number of squares on the board (n*n).
//   - Board Flattening (creating squareContentMap): Iterates through all n*n squares once. O(N_squares).
//   - BFS Traversal (performBFS):
//     - Each square (1 to N_squares) is added to the queue and visited set at most once.
//     - For each square, we explore at most 6 possible next squares (dice rolls).
//     - Assuming effective O(1) queue operations (enqueue and dequeue), BFS is O(Nodes + Edges) = O(N_squares + 6*N_squares) = O(N_squares).
//     - Note: `Array.removeFirst()` can be O(queue_size) in Swift. For optimal performance with large queues, a custom Deque might be preferred.
//   - Overall: O(N_squares) + O(N_squares) = O(N_squares).
//
// Space Complexity: O(N_squares), where N_squares is the total number of squares (n*n).
//   - squareContentMap: Stores N_squares entries. O(N_squares).
//   - performBFS internal structures:
//     - squaresToVisitQueue: In the worst case, can hold up to O(N_squares) squares. O(N_squares).
//     - visitedSquares: Stores up to N_squares squares. O(N_squares).
//   - Overall: O(N_squares) + O(N_squares) + O(N_squares) = O(N_squares).

class Solution {
    func snakesAndLadders(_ board: [[Int]]) -> Int {
        let boardSideLength = board.count
        let finalTargetSquare = boardSideLength * boardSideLength

        // Flatten the board: map each square number (1 to N*N) to its content (-1 or snake/ladder destination).
        // The board is numbered in a Boustrophedon ("ox-turning") manner.
        var squareContentMap: [Int: Int] = [:]
        var currentSquareLabel = finalTargetSquare // Start labeling from the highest square number.
        
        // Iterate through the board rows from top (i=0) to bottom (i=n-1).
        for rowIndex in 0..<boardSideLength {
            // Determine column traversal direction based on the row's parity from the bottom.
            // (boardSideLength - 1 - rowIndex) is the 0-indexed row from the bottom.
            // If (boardSideLength - 1 - rowIndex) is even, row is traversed L->R for labeling.
            // If (boardSideLength - 1 - rowIndex) is odd, row is traversed R->L for labeling.
            // The condition `(boardSideLength - rowIndex) % 2 == 0` correctly captures this for filling `currentSquareLabel` downwards.
            let isRowProcessedLeftToRightForLabeling = (boardSideLength - rowIndex) % 2 == 0
            
            for colOffsetInRow in 0..<boardSideLength {
                let boardCellValue: Int
                if isRowProcessedLeftToRightForLabeling {
                    // For these rows, effective column order is standard L->R when mapping labels N*N down to 1.
                    boardCellValue = board[rowIndex][colOffsetInRow]
                } else {
                    // For other rows, effective column order is R->L when mapping labels N*N down to 1.
                    boardCellValue = board[rowIndex][boardSideLength - colOffsetInRow - 1]
                }
                squareContentMap[currentSquareLabel] = boardCellValue
                currentSquareLabel -= 1
            }
        }
        
        // --- Reusable BFS function ---
        // Performs a Breadth-First Search to find the shortest number of moves.
        func performBFS(from startSquare: Int) -> Int {
            var numberOfMoves = 0
            var squaresToVisitQueue = [Int]() // Queue for BFS, stores square numbers.
            var visitedSquares = Set<Int>()   // Set to keep track of visited squares.
            
            squaresToVisitQueue.append(startSquare) // Start BFS from the initial square.
            visitedSquares.insert(startSquare)
            
            while !squaresToVisitQueue.isEmpty {
                let squaresAtCurrentLevel = squaresToVisitQueue.count // Number of squares to process at the current move count.
                
                for _ in 0..<squaresAtCurrentLevel {
                    let currentSquare = squaresToVisitQueue.removeFirst() // Dequeue the current square.
                    
                    if currentSquare == finalTargetSquare { // Check if we reached the final target.
                        return numberOfMoves
                    }
                    
                    // Explore possible next squares by rolling a dice (1 to 6).
                    for diceRollValue in 1...6 {
                        var nextPotentialSquare = currentSquare + diceRollValue
                        
                        if nextPotentialSquare > finalTargetSquare { continue } // Skip if roll overshoots the board.
                        
                        // Check if the potential square has a snake or a ladder.
                        // If squareMap[nextPotentialSquare] exists and is not -1, it's a snake/ladder.
                        if let snakeOrLadderDestination = squareContentMap[nextPotentialSquare], snakeOrLadderDestination != -1 {
                            nextPotentialSquare = snakeOrLadderDestination // Update to the snake/ladder's destination.
                        }
                        
                        // If this new square (after potential snake/ladder) hasn't been visited,
                        // add it to the queue and mark as visited.
                        if !visitedSquares.contains(nextPotentialSquare) {
                            squaresToVisitQueue.append(nextPotentialSquare)
                            visitedSquares.insert(nextPotentialSquare)
                        }
                    }
                }
                numberOfMoves += 1 // Increment moves after processing all squares at the current level.
            }
            
            return -1 // Target square is not reachable.
        }
        // --- End of BFS function ---
        
        // Call the BFS function starting from square 1.
        return performBFS(from: 1)
    }
}