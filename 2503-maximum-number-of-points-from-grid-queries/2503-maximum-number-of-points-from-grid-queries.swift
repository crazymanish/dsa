class Solution {
    func maxPoints(_ grid: [[Int]], _ queries: [Int]) -> [Int] {
        let rowCount = grid.count // Number of rows in the grid
        let colCount = grid[0].count // Number of columns in the grid
        let sortedQueriesWithIndex = Array(queries.enumerated()).sorted { $0.1 < $1.1 } // Sort queries by their value, keeping track of original index
        var answer = [Int](repeating: -1, count: queries.count) // Array to store the results for each query, initialized with -1

        var minHeap = Heap([Cell(row: 0, col: 0, value: grid[0][0])]) // Initialize a min-heap with the starting cell (0, 0)
        var visited = [[Bool]](repeating: [Bool](repeating: false, count: colCount), count: rowCount) // 2D array to track visited cells
        visited[0][0] = true // Mark the starting cell as visited
        var cellCount = 0 // Counter for the number of reachable cells
        var queryIndex = 0 // Index for iterating through the sorted queries

        // Process cells in increasing order of their value using a min-heap
        while let currentCell = minHeap.popMin() {
            // Process all queries whose value is less than or equal to the current cell value
            while queryIndex < queries.count && currentCell.value >= sortedQueriesWithIndex[queryIndex].1 {
                answer[sortedQueriesWithIndex[queryIndex].0] = cellCount // Store the count of reachable cells for the current query
                queryIndex += 1 // Move to the next query
            }
            if queryIndex == queries.count { break } // If all queries are processed, break the loop

            cellCount += 1 // Increment the count of reachable cells

            // Explore the unvisited neighbors of the current cell
            for (deltaRow, deltaCol) in [(1, 0), (0, 1), (-1, 0), (0, -1)] {
                let newRow = currentCell.row + deltaRow
                let newCol = currentCell.col + deltaCol

                // Check if the neighbor cell is within the grid bounds and not visited
                if newRow >= 0 && newRow < rowCount && newCol >= 0 && newCol < colCount && !visited[newRow][newCol] {
                    visited[newRow][newCol] = true // Mark the neighbor cell as visited
                    minHeap.insert(Cell(row: newRow, col: newCol, value: grid[newRow][newCol])) // Add the neighbor cell to the min-heap
                }
            }
        }

        // Handle any remaining queries (whose values are greater than the maximum cell value)
        while queryIndex < queries.count {
            answer[sortedQueriesWithIndex[queryIndex].0] = cellCount // Store the final count for the remaining queries
            queryIndex += 1
        }

        return answer // Return the array of answers for each query
    }
}

struct Cell: Comparable {
    let row: Int, col: Int, value: Int // Represents a cell in the grid with row, column, and value
    static func < (lhs: Cell, rhs: Cell) -> Bool { lhs.value < rhs.value } // Comparator for min-heap
}