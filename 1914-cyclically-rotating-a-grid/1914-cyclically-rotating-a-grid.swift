class Solution {
    /**
     Problem Summary:
     Rotate each rectangular layer of the grid counter-clockwise by `k` positions.

     Strategy:
     - Process the grid layer by layer from the outside inward.
     - Extract each layer's values in counter-clockwise traversal order.
     - Instead of creating a separate rotated array, use modular indexing while writing values back.
     - Write each value back into the same traversal position shifted by `k`.

     Time Complexity:
     O(m * n), where `m` is the number of rows and `n` is the number of columns.

     Space Complexity:
     O(m + n) for storing one layer at a time.
     */
    func rotateGrid(_ grid: [[Int]], _ k: Int) -> [[Int]] {
        let rowCount = grid.count
        let columnCount = grid[0].count
        let layerCount = min(rowCount, columnCount) / 2

        var rotatedGrid = grid

        for layerIndex in 0..<layerCount {
            let topRow = layerIndex
            let leftColumn = layerIndex
            let bottomRow = rowCount - 1 - layerIndex
            let rightColumn = columnCount - 1 - layerIndex

            var layerValues: [Int] = []

            // Extract the top edge from left to right, excluding the top-right corner.
            for column in leftColumn..<rightColumn {
                layerValues.append(rotatedGrid[topRow][column])
            }

            // Extract the right edge from top to bottom, excluding the bottom-right corner.
            for row in topRow..<bottomRow {
                layerValues.append(rotatedGrid[row][rightColumn])
            }

            // Extract the bottom edge from right to left, excluding the bottom-left corner.
            for column in stride(from: rightColumn, to: leftColumn, by: -1) {
                layerValues.append(rotatedGrid[bottomRow][column])
            }

            // Extract the left edge from bottom to top, excluding the top-left corner.
            for row in stride(from: bottomRow, to: topRow, by: -1) {
                layerValues.append(rotatedGrid[row][leftColumn])
            }

            let layerLength = layerValues.count
            let rotationOffset = k % layerLength
            var valueIndex = 0

            // Write back the top edge using modular indexing instead of a separate rotated array.
            for column in leftColumn..<rightColumn {
                let rotatedIndex = (valueIndex + rotationOffset) % layerLength
                rotatedGrid[topRow][column] = layerValues[rotatedIndex]
                valueIndex += 1
            }

            // Write back the right edge.
            for row in topRow..<bottomRow {
                let rotatedIndex = (valueIndex + rotationOffset) % layerLength
                rotatedGrid[row][rightColumn] = layerValues[rotatedIndex]
                valueIndex += 1
            }

            // Write back the bottom edge.
            for column in stride(from: rightColumn, to: leftColumn, by: -1) {
                let rotatedIndex = (valueIndex + rotationOffset) % layerLength
                rotatedGrid[bottomRow][column] = layerValues[rotatedIndex]
                valueIndex += 1
            }

            // Write back the left edge.
            for row in stride(from: bottomRow, to: topRow, by: -1) {
                let rotatedIndex = (valueIndex + rotationOffset) % layerLength
                rotatedGrid[row][leftColumn] = layerValues[rotatedIndex]
                valueIndex += 1
            }
        }

        return rotatedGrid
    }
}