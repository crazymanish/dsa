// Time Complexity: O(M * N * log(M * N))
// The algorithm processes each of the M*N cells once. For each cell, it performs
// operations on a priority queue (min-heap). In the worst case, the heap can
// contain all M*N cells. Heap insertion and extraction each take logarithmic time
// relative to the heap size.
// NOTE: The implementation below simulates a heap with a sorted array. Re-sorting
// the array after every insertion is inefficient. A true heap data structure
// would be required to achieve the optimal time complexity.
//
// Space Complexity: O(M * N)
// We use a `visited` matrix of size M*N and a priority queue that can, in the
// worst case, store all M*N cells.
import Foundation

class Solution {
    func trapRainWater(_ heightMap: [[Int]]) -> Int {
        // A grid must be at least 3x3 to trap any water internally.
        guard heightMap.count > 2, heightMap[0].count > 2 else { return 0 }
        
        let rows = heightMap.count
        let cols = heightMap[0].count
        
        // A min-heap to always process the cell with the lowest height on the boundary.
        // This cell's height acts as the current "water level" for trapping.
        // Stored as a tuple: (height, row, col)
        var minHeap = [(Int, Int, Int)]()
        
        // A matrix to keep track of visited cells to prevent reprocessing.
        var visited = Array(repeating: Array(repeating: false, count: cols), count: rows)
        
        // Initialize the process by adding all border cells to the heap.
        // These cells form the initial "sea wall" that contains the water.
        for r in 0..<rows {
            for c in 0..<cols {
                if r == 0 || r == rows - 1 || c == 0 || c == cols - 1 {
                    minHeap.append((heightMap[r][c], r, c))
                    visited[r][c] = true
                }
            }
        }
        
        // Build the initial min-heap from the border cells.
        minHeap.sort { $0.0 < $1.0 }
        
        // Directions for exploring neighbors: up, down, left, right.
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        
        var waterTrapped = 0
        
        // Process cells from the heap until it's empty. The algorithm spreads
        // inward from the boundaries, similar to Dijkstra's or a Best-First Search.
        while !minHeap.isEmpty {
            // Pop the cell with the minimum height from our boundary. This height
            // represents the current effective water level or "wall height."
            let (height, row, col) = minHeap.removeFirst()
            
            // Explore the four neighbors of this boundary cell.
            for direction in directions {
                let newRow = row + direction.0
                let newCol = col + direction.1
                
                // Check if the neighbor is within bounds and has not been visited.
                if newRow >= 0, newRow < rows, newCol >= 0, newCol < cols, !visited[newRow][newCol] {
                    visited[newRow][newCol] = true
                    let newHeight = heightMap[newRow][newCol]
                    
                    // If the boundary wall (`height`) is taller than the neighbor's floor (`newHeight`),
                    // water is trapped. The amount is the difference in height.
                    if height > newHeight {
                        waterTrapped += height - newHeight
                    }
                    
                    // Add the neighbor to our boundary (the heap). The effective height of this new
                    // boundary point is its own height or the height of the water that flowed into it,
                    // whichever is greater. This ensures the "wall" never gets lower.
                    let updatedHeight = max(height, newHeight)
                    minHeap.append((updatedHeight, newRow, newCol))
                    
                    // Re-sort to maintain the min-heap property. Using a dedicated heap
                    // data structure would be more performant than sorting the entire array.
                    minHeap.sort { $0.0 < $1.0 }
                }
            }
        }
        
        return waterTrapped
    }
}