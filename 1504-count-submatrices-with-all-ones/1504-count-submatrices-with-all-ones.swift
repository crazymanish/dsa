// Time Complexity: O(R * C^2)
//  - R: Number of rows in the matrix.
//  - C: Number of columns in the matrix.
//  - The algorithm has two main phases:
//    1. Pre-computation of `heights`: This takes O(R * C) as we visit each cell once.
//    2. Counting Submatrices: We iterate through each cell (R * C). For each cell (r, c),
//       we then iterate leftwards up to `c` times. This results in O(R * C * C).
//  - The total complexity is dominated by the counting phase.
//
// Space Complexity: O(R * C)
//  - An auxiliary matrix `heights` of the same dimensions as the input is used to store
//    the height of contiguous ones ending at each cell.
class Solution {
    /**
     * Counts the total number of submatrices containing only ones.
     *
     * The approach uses dynamic programming with a pre-computation step.
     *
     * 1.  **Pre-computation:** First, we create an auxiliary matrix `heights` of the same size.
     * `heights[r][c]` will store the number of contiguous `1`s directly above and
     * including the cell `(r, c)`. If `mat[r][c]` is 0, the height is 0.
     *
     * 2.  **Counting:** After `heights` is computed, we iterate through each cell `(r, c)`.
     * For each cell, we count the number of submatrices that have `(r, c)` as their
     * **bottom-right corner**. To do this, we look leftwards from `c`. For any rectangle
     * of width `w` ending at `(r, c)`, its height is limited by the minimum height of
     * all columns within that `w`-wide block. We sum these possible heights for all
     * possible widths (from 1 to `c+1`).
     *
     * - Parameter mat: An M x N matrix of 0s and 1s.
     * - Returns: The total number of submatrices containing all ones.
     */
    func numSubmat(_ mat: [[Int]]) -> Int {
        guard !mat.isEmpty, !mat[0].isEmpty else { return 0 }
        
        let rows = mat.count
        let cols = mat[0].count
        
        // --- Step 1: Pre-compute the height of consecutive 1s for each column ---
        var heights = Array(repeating: Array(repeating: 0, count: cols), count: rows)
        for r in 0..<rows {
            for c in 0..<cols {
                if mat[r][c] == 1 {
                    // The height at (r, c) is 1 + the height of the cell above it.
                    heights[r][c] = (r > 0 ? heights[r - 1][c] : 0) + 1
                }
            }
        }
        
        var totalSubmatrices = 0
        
        // --- Step 2: Count submatrices ending at each cell (r, c) ---
        for r in 0..<rows {
            for c in 0..<cols {
                // For each cell (r, c), iterate leftwards to find all possible rectangle widths.
                var minHeightInWindow = Int.max
                for k in (0...c).reversed() {
                    // The height of any rectangle ending at (r, c) with a width of (c - k + 1)
                    // is limited by the shortest column in that window.
                    minHeightInWindow = min(minHeightInWindow, heights[r][k])
                    
                    // If the shortest column has height 0, no rectangle can be formed.
                    if minHeightInWindow == 0 {
                        break
                    }
                    
                    // Add the number of possible rectangles of this width.
                    // If minHeight is `h`, we can form `h` different rectangles
                    // (1x_width, 2x_width, ..., hx_width).
                    totalSubmatrices += minHeightInWindow
                }
            }
        }
        
        return totalSubmatrices
    }
}