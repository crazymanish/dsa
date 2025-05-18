class Solution {
    func colorTheGrid(_ numRows: Int, _ numCols: Int) -> Int {
        // Modulo constant for calculations to prevent overflow.
        let MOD = 1_000_000_007
        // Number of available colors for painting the grid cells.
        let NUM_COLORS = 3

        // --- Time and Space Complexity Analysis ---
        // Let N_masks be the number of valid column patterns.
        // N_masks is at most NUM_COLORS * (NUM_COLORS - 1)^(numRows - 1). For NUM_COLORS = 3, N_masks = 3 * 2^(numRows - 1).
        //
        // 1. Generating validColumnPatterns (backtrack):
        //    - Time: O(numRows * N_masks) because each of N_masks patterns takes O(numRows) to build.
        //    - Space: O(N_masks) to store the patterns, and O(numRows) for recursion stack.
        //
        // 2. Building patternAdjacency graph:
        //    - Time: O(N_masks^2 * numRows). We iterate over all pairs of masks (N_masks^2)
        //      and for each pair, we compare numRows cells.
        //    - Space: O(N_masks^2) in the worst case if the graph is dense. Each pattern can potentially
        //      be adjacent to many other patterns. More precisely, O(N_masks + Edges), where Edges <= N_masks^2.
        //
        // 3. Dynamic Programming Iteration:
        //    - Time: O(numCols * N_masks * avg_degree_of_adjacency_graph). In the worst case, avg_degree can be N_masks.
        //      So, O(numCols * N_masks^2).
        //    - Space: O(N_masks) for dpWaysPrevColumn and dpWaysCurrentColumn arrays.
        //
        // Overall Time Complexity: O(numRows * N_masks + numRows * N_masks^2 + numCols * N_masks^2)
        //                       = O((numRows + numCols) * N_masks^2)
        //                       = O((numRows + numCols) * (3 * 2^(numRows - 1))^2)
        //                       = O((numRows + numCols) * 9 * 4^(numRows - 1))
        // Overall Space Complexity: O(N_masks^2) due to the adjacency list.
        //                        = O((3 * 2^(numRows - 1))^2)
        //                        = O(9 * 4^(numRows - 1))
        //
        // Constraints: numRows is small (e.g., 1 to 5), numCols can be larger.
        // If numRows = 5, N_masks = 3 * 2^4 = 48. N_masks^2 approx 2300.
        // (5 + numCols) * 2300. If numCols = 1000, then 1005 * 2300 ~ 2.3 * 10^6 operations, which is feasible.

        // Stores all valid ways to color a single column of height `numRows`.
        // Each pattern is an integer where digits in base NUM_COLORS represent colors.
        var validColumnPatterns: [Int] = []

        // Recursive function to generate all valid single-column color patterns.
        // - rowIndexInColumn: The current row (0 to numRows-1) we are trying to color in the column.
        // - patternBeingBuilt: The integer representation of the column pattern built so far for rows 0 to rowIndexInColumn-1.
        func generateColumnPatterns(_ rowIndexInColumn: Int, _ patternBeingBuilt: Int) {
            // Base case: If all rows in the column have been colored.
            if rowIndexInColumn == numRows {
                validColumnPatterns.append(patternBeingBuilt)
                return
            }

            // Try assigning each color to the current cell (rowIndexInColumn).
            for colorCode in 0..<NUM_COLORS {
                // Constraint: The new color must be different from the color of the cell directly above it (if one exists).
                // The color of the cell above (at rowIndexInColumn-1) is the last color added to patternBeingBuilt.
                if rowIndexInColumn == 0 || (patternBeingBuilt % NUM_COLORS) != colorCode {
                    // Append the new colorCode to the pattern and recurse for the next row.
                    // patternBeingBuilt * NUM_COLORS shifts existing colors to higher "digits",
                    // then + colorCode adds the new color in the lowest "digit".
                    generateColumnPatterns(rowIndexInColumn + 1, patternBeingBuilt * NUM_COLORS + colorCode)
                }
            }
        }
        
        generateColumnPatterns(0, 0) // Start generation for the first row with an empty pattern.

        let numUniquePatterns = validColumnPatterns.count
        if numUniquePatterns == 0 { // Should not happen for valid inputs numRows >= 1
            return 0
        }

        // Build an adjacency list for column patterns.
        // patternAdjacency[i] will store a set of indices `j` such that
        // validColumnPatterns[j] can be placed immediately to the right of validColumnPatterns[i].
        var patternAdjacency: [Set<Int>] = Array(repeating: [], count: numUniquePatterns)
        for i in 0..<numUniquePatterns {
            let pattern1 = validColumnPatterns[i]
            for j in 0..<numUniquePatterns {
                let pattern2 = validColumnPatterns[j]
                
                var tempPattern1 = pattern1
                var tempPattern2 = pattern2
                var arePatternsAdjacent = true
                // Check each corresponding cell in the two patterns.
                for _ in 0..<numRows {
                    // If colors at the same row level are identical, they cannot be adjacent.
                    if tempPattern1 % NUM_COLORS == tempPattern2 % NUM_COLORS {
                        arePatternsAdjacent = false
                        break
                    }
                    // Move to the next cell (row) in the patterns (effectively integer division by NUM_COLORS).
                    tempPattern1 /= NUM_COLORS
                    tempPattern2 /= NUM_COLORS
                }

                if arePatternsAdjacent {
                    patternAdjacency[i].insert(j)
                }
            }
        }

        // Dynamic Programming: Iterate column by column.
        // dpWaysPrevColumn[i] = number of ways to color the grid up to the previous column,
        //                       with the previous column having pattern validColumnPatterns[i].
        var dpWaysPrevColumn = Array(repeating: 1, count: numUniquePatterns)

        // Iterate for columns from the second column up to numCols.
        // (The first column's ways are initialized in dpWaysPrevColumn).
        for _ in 1..<numCols { // Loop numCols-1 times
            // dpWaysCurrentColumn[j] = number of ways to color the grid up to the current column,
            //                          with the current column having pattern validColumnPatterns[j].
            var dpWaysCurrentColumn = Array(repeating: 0, count: numUniquePatterns)
            
            // For each possible pattern in the previous column:
            for prevPatternIndex in 0..<numUniquePatterns {
                if dpWaysPrevColumn[prevPatternIndex] == 0 { continue } // Optimization: no ways to reach this prev_pattern

                // For each pattern that can validly follow the prevPatternIndex:
                for currentPatternIndex in patternAdjacency[prevPatternIndex] {
                    dpWaysCurrentColumn[currentPatternIndex] = (dpWaysCurrentColumn[currentPatternIndex] + dpWaysPrevColumn[prevPatternIndex]) % MOD
                }
            }
            // Move to the next column: current column's ways become previous column's ways for the next iteration.
            dpWaysPrevColumn = dpWaysCurrentColumn
        }

        // The total number of ways is the sum of ways to end with any valid pattern in the last column.
        var totalWays = 0
        for ways in dpWaysPrevColumn {
            totalWays = (totalWays + ways) % MOD
        }
        
        return totalWays
    }
}
