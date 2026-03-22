/**
 Problem Summary:
 Determine whether a given square matrix `mat` can be rotated (in 0°, 90°, 180°, or 270°)
 to match another matrix `target`.

 Strategy:
 Instead of physically rotating the matrix, we simulate each rotation by mapping indices.
 For each rotation, we compare elements of `mat` with the corresponding rotated position in `target`.

 Rotations mapping:
 - 0°   → (row, col)
 - 90°  → (col, n - 1 - row)
 - 180° → (n - 1 - row, n - 1 - col)
 - 270° → (n - 1 - col, row)

 We check all four possibilities using a helper function.

 Time Complexity:
 O(n²) — we traverse the matrix up to 4 times

 Space Complexity:
 O(1) — no extra space used
 */

class Solution {
    func findRotation(_ matrix: [[Int]], _ target: [[Int]]) -> Bool {
        let size = matrix.count

        // Helper function to validate a rotation using index mapping
        func matchesRotation(_ mapping: (Int, Int) -> Bool) -> Bool {
            for row in 0..<size {
                for col in 0..<size {
                    // If any element doesn't match, this rotation is invalid
                    if !mapping(row, col) {
                        return false
                    }
                }
            }
            
            return true
        }

        // Check all four rotation possibilities
        return
            // 0° rotation (no change)
            matchesRotation { row, col in
                matrix[row][col] == target[row][col]
            }
            ||
            // 90° rotation
            matchesRotation { row, col in
                matrix[row][col] == target[col][size - 1 - row]
            }
            ||
            // 180° rotation
            matchesRotation { row, col in
                matrix[row][col] == target[size - 1 - row][size - 1 - col]
            }
            ||
            // 270° rotation
            matchesRotation { row, col in
                matrix[row][col] == target[size - 1 - col][row]
            }
    }
}