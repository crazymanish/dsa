// Time Complexity: O(1)
// The input Sudoku board is always a fixed size (9x9). The algorithm iterates through
// each of the 81 cells exactly once. All operations inside the loop (set insertions
// and lookups) are effectively O(1) as the sets never contain more than 9 elements.
// Therefore, the total runtime is constant.
// (For a generic N x N board, the complexity would be O(N^2)).
//
// Space Complexity: O(1)
// We use three data structures to track the numbers seen in each row, column, and box.
// For a 9x9 board, this means 9 sets for rows, 9 for columns, and 9 for boxes. The size
// of each set is also at most 9. This results in a constant amount of memory usage.
// (For a generic N x N board, the complexity would be O(N^2)).
class Solution {
    /**
     * Determines if a 9x9 Sudoku board is valid.
     *
     * The strategy is to iterate through the board once, keeping track of the numbers
     * seen in each row, each column, and each 3x3 sub-box. We use sets for efficient
     * duplicate detection. For each cell containing a digit, we attempt to insert it
     * into the three corresponding sets (one for its row, one for its column, and one
     * for its 3x3 box). If any of these insertions fail (because the digit is already
     * present), we have found a duplicate, and the board is invalid.
     *
     * - Parameter board: A 9x9 2D array of Characters representing the Sudoku board.
     * - Returns: `true` if the board is valid, `false` otherwise.
     */
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        // We need 9 sets for rows, 9 for columns, and a 3x3 grid of sets for the sub-boxes.
        var rowSets = [Set<Character>](repeating: Set<Character>(), count: 9)
        var colSets = [Set<Character>](repeating: Set<Character>(), count: 9)
        var boxSets = [[Set<Character>]](repeating: [Set<Character>](repeating: Set<Character>(), count: 3), count: 3)
        
        for r in 0..<9 {
            for c in 0..<9 {
                let digit = board[r][c]
                
                // Skip empty cells.
                if digit == "." {
                    continue
                }
                
                // --- Check for Duplicates ---
                // We can combine the check and insertion into one step. The `insert` method
                // on a Set returns a tuple `(inserted: Bool, memberAfterInsert: Element)`.
                // The `inserted` boolean is `false` if the element was already in the set.
                
                // Check the current row
                if !rowSets[r].insert(digit).inserted {
                    return false
                }
                
                // Check the current column
                if !colSets[c].insert(digit).inserted {
                    return false
                }
                
                // Check the current 3x3 sub-box
                // Integer division (r/3, c/3) maps a cell's coordinates to its box's coordinates.
                let boxRow = r / 3
                let boxCol = c / 3
                if !boxSets[boxRow][boxCol].insert(digit).inserted {
                    return false
                }
            }
        }

        // If we iterate through the entire board without finding any duplicates, it's valid.
        return true
    }
}