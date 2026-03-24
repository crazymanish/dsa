/**
 Problem Summary:
 Given a 2D grid, return a matrix where each cell contains the product
 of all other elements except itself, modulo 12345.

 Strategy:
 - Treat the grid as a flattened array.
 - First pass (left → right):
     Build result array where result[i] holds product of all elements before i.
 - Second pass (right → left):
     Multiply result[i] by product of all elements after i.
 - This eliminates the need for a separate suffix array.

 Key Insight:
 We reuse the result array to store prefix products and accumulate suffix
 products in a running variable, reducing space usage.

 Time Complexity:
 O(n * m)

 Space Complexity:
 O(1) extra (excluding output array)
 */

class Solution {
    func constructProductMatrix(_ grid: [[Int]]) -> [[Int]] {
        let modulo = 12345
        let rowCount = grid.count
        let columnCount = grid[0].count
        let totalElements = rowCount * columnCount
        
        // Flatten grid for linear processing
        var flattenedGrid: [Int] = []
        flattenedGrid.reserveCapacity(totalElements)
        for row in grid {
            flattenedGrid.append(contentsOf: row)
        }
        
        // Step 1: Build prefix products directly into result array
        var resultFlattened = Array(repeating: 1, count: totalElements)
        
        for index in 1..<totalElements {
            resultFlattened[index] = (resultFlattened[index - 1] * flattenedGrid[index - 1]) % modulo
        }
        
        // Step 2: Traverse from right and accumulate suffix product
        var suffixProduct = 1
        
        for index in stride(from: totalElements - 1, through: 0, by: -1) {
            // Multiply prefix (already stored) with suffix
            resultFlattened[index] = (resultFlattened[index] * suffixProduct) % modulo
            
            // Update suffix product for next iteration
            suffixProduct = (suffixProduct * flattenedGrid[index]) % modulo
        }
        
        // Convert flattened result back to 2D matrix
        var resultMatrix = Array(
            repeating: Array(repeating: 0, count: columnCount),
            count: rowCount
        )
        
        for index in 0..<totalElements {
            let row = index / columnCount
            let column = index % columnCount
            resultMatrix[row][column] = resultFlattened[index]
        }
        
        return resultMatrix
    }
}