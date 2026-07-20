/// Problem Summary:
/// Shift every element in the grid to the right by `k` positions.
/// Elements that move past the last column wrap to the next row,
/// and elements that move past the last row wrap to the first row.
///
/// Strategy:
/// Calculate each element's destination directly using row and column
/// offsets, then write it into a separate result grid.
///
/// Time Complexity: O(m × n)
/// Space Complexity: O(m × n)
class Solution {
    func shiftGrid(_ grid: [[Int]], _ shiftCount: Int) -> [[Int]] {
        guard !grid.isEmpty, !grid[0].isEmpty, shiftCount != 0 else {
            return grid
        }

        let rowCount = grid.count
        let columnCount = grid[0].count
        var shiftedGrid = grid

        for row in 0..<rowCount {
            for column in 0..<columnCount {
                // Calculate the destination column after shifting.
                let destinationColumn = (column + shiftCount) % columnCount

                // Every full column crossed moves the element to the next row.
                let rowsMoved = (column + shiftCount) / columnCount
                let destinationRow = (row + rowsMoved) % rowCount

                shiftedGrid[destinationRow][destinationColumn] = grid[row][column]
            }
        }

        return shiftedGrid
    }
}