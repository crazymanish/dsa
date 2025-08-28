// Time Complexity: O(N^2 * log N)
//   - N: The side length of the square grid.
//   - The algorithm has two main phases:
//     1. Grouping: We iterate through the N*N grid once to group elements by their
//        anti-diagonal. This takes O(N^2) time.
//     2. Sorting & Placing: We iterate through each of the 2N-1 anti-diagonals. For each
//        diagonal of length `k`, we sort it, which takes O(k * log k). The sum of all `k*log(k)`
//        across all diagonals is bounded by O(N^2 * log N), as the longest diagonal has length N.
//        Placing elements back takes O(N^2) in total.
//   - The sorting step is the bottleneck, leading to the final complexity.
//
// Space Complexity: O(N^2)
//   - The `antiDiagonals` dictionary stores all N^2 elements of the grid.
//   - A mutable copy of the grid is also created.
//   - Therefore, the space required is proportional to the size of the grid.
class Solution {
    /**
     * Sorts the anti-diagonals of a square matrix according to specific rules.
     *
     * The strategy involves two main steps:
     * 1.  **Grouping:** All elements are extracted from the grid and grouped by the anti-diagonal
     * they belong to. A key insight is that for any cell (i, j), the value `i - j` is
     * constant along a given anti-diagonal. We use this value as a key in a dictionary.
     * 2.  **Sorting and Placing:** Each collected anti-diagonal is then sorted.
     * - Anti-diagonals in the lower-left half (including the main one, where `i - j >= 0`)
     * are sorted in descending order.
     * - Anti-diagonals in the upper-right half (`i - j < 0`) are sorted in ascending order.
     * The sorted values are then placed back into a copy of the original grid.
     *
     * - Parameter grid: An N x N matrix of integers.
     * - Returns: The matrix with its anti-diagonals sorted as described.
     */
    func sortMatrix(_ grid: [[Int]]) -> [[Int]] {
        guard !grid.isEmpty, !grid[0].isEmpty else {
            return []
        }
        let n = grid.count
        
        // Step 1: Group elements by their anti-diagonal key (i - j).
        var antiDiagonals = [Int: [Int]]()
        for i in 0..<n {
            for j in 0..<n {
                antiDiagonals[i - j, default: []].append(grid[i][j])
            }
        }
        
        var sortedGrid = grid // Create a mutable copy to populate.
        
        // Step 2: Iterate through the grouped diagonals, sort them, and place them back.
        for (diagonalKey, diagonalValues) in antiDiagonals {
            let count = diagonalValues.count
            
            if diagonalKey >= 0 {
                // This block handles the main anti-diagonal (key=0) and all below it (key>0).
                // These are sorted in DESCENDING order.
                let sortedValues = diagonalValues.sorted(by: >)
                
                // Place the sorted values back. For these diagonals, the coordinates are of
                // the form (k + diagonalKey, k), where k is the column index.
                for i in 0..<count {
                    let col = i
                    let row = i + diagonalKey
                    sortedGrid[row][col] = sortedValues[i]
                }
            } else { // diagonalKey < 0
                // This block handles all anti-diagonals above the main one.
                // These are sorted in ASCENDING order.
                let sortedValues = diagonalValues.sorted(by: <)

                // Place the sorted values back. For these diagonals, the coordinates are of
                // the form (k, k - diagonalKey), where k is the row index.
                for i in 0..<count {
                    let row = i
                    let col = i - diagonalKey // Subtracting the negative key
                    sortedGrid[row][col] = sortedValues[i]
                }
            }
        }
        
        return sortedGrid
    }
}