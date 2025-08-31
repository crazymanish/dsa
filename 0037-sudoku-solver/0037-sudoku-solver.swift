// Time Complexity: O(9^E) where E is the number of empty cells.
//  - In the worst-case scenario, for each of the E empty cells, we might have to try up to 9
//    different numbers. This leads to an exponential time complexity.
//  - However, due to the constraints of Sudoku, the actual runtime is much faster because
//    many branches of the recursion are pruned early by the `isValid` check.
//
// Space Complexity: O(E) or O(1)
//  - The space complexity is determined by the maximum depth of the recursion call stack.
//  - The recursion depth is equal to the number of empty cells, E.
//  - Since the board size is fixed (9x9), the maximum number of empty cells is 81.
//    Therefore, the space complexity is technically constant, O(1).
class Solution {
    /**
     * Solves a Sudoku puzzle by modifying the board in-place.
     *
     * - Parameter board: A 9x9 2D array of Characters representing the Sudoku board,
     * with '.' indicating empty cells.
     */
    func solveSudoku(_ board: inout [[Character]]) {
        // This is the main entry point. We call a recursive helper function
        // that will attempt to solve the puzzle.
        _ = backtrack(&board)
    }
    
    /**
     * A recursive backtracking helper function.
     *
     * It works by finding the first empty cell, trying to place a valid digit ('1'-'9')
     * in it, and then recursively calling itself to solve the rest of the board.
     * If a choice leads to an unsolvable state, it backtracks by undoing the choice.
     *
     * - Parameter board: The Sudoku board to solve.
     * - Returns: `true` if a solution is found, `false` otherwise.
     */
    private func backtrack(_ board: inout [[Character]]) -> Bool {
        // Find the next empty cell ('.') to fill.
        for row in 0..<9 {
            for col in 0..<9 {
                if board[row][col] == "." {
                    // Try placing each digit from '1' to '9'.
                    for digit in "123456789" {
                        // Check if the current digit placement is valid.
                        if isValid(board, row, col, digit) {
                            // --- Make the move ---
                            board[row][col] = digit
                            
                            // --- Recurse ---
                            // If the rest of the board can be solved with this move, we are done.
                            if backtrack(&board) {
                                return true
                            }
                            
                            // --- Backtrack ---
                            // If the recursive call returned false, our choice was wrong.
                            // Undo the move and try the next digit.
                            board[row][col] = "."
                        }
                    }
                    // If no digit from '1'-'9' works for this cell, it means a previous
                    // choice was wrong. Return false to trigger backtracking in the caller.
                    return false
                }
            }
        }
        
        // Base Case: If we iterate through the entire board and find no empty cells,
        // it means the puzzle is solved.
        return true
    }
    
    /**
     * Checks if placing a given digit at a specific cell is valid according to Sudoku rules.
     * (Note: For higher performance, this check could be optimized using sets to track
     * used digits, reducing validation from O(N) to O(1)).
     */
    private func isValid(_ board: [[Character]], _ row: Int, _ col: Int, _ digit: Character) -> Bool {
        // This loop cleverly checks the row, column, and 3x3 box in a single pass.
        for i in 0..<9 {
            // Check for the digit in the current row.
            if board[row][i] == digit {
                return false
            }
            
            // Check for the digit in the current column.
            if board[i][col] == digit {
                return false
            }
            
            // Check for the digit in the current 3x3 sub-box.
            // The formula maps the outer loop index `i` (0..8) to the 9 cells of the box.
            // - `3 * (row / 3)`: Gives the top-left row of the box (0, 3, or 6).
            // - `i / 3`: Gives the row offset within the box (0, 1, or 2).
            // - `3 * (col / 3)`: Gives the top-left column of the box (0, 3, or 6).
            // - `i % 3`: Gives the column offset within the box (0, 1, or 2).
            let boxRow = 3 * (row / 3) + i / 3
            let boxCol = 3 * (col / 3) + i % 3
            if board[boxRow][boxCol] == digit {
                return false
            }
        }
        
        // If no conflicts are found, the move is valid.
        return true
    }
}