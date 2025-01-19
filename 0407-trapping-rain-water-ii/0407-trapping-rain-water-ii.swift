import Foundation

class Solution {
    func trapRainWater(_ heightMap: [[Int]]) -> Int {
        // Edge case: if the heightMap is empty or has less than 3 rows or columns, no water can be trapped
        guard heightMap.count > 2, heightMap[0].count > 2 else { return 0 }
        
        let rows = heightMap.count
        let cols = heightMap[0].count
        
        // Priority queue (min-heap) to process the lowest height cell first
        var minHeap = [(Int, Int, Int)]() // (height, row, col)
        
        // Visited array to keep track of visited cells
        var visited = Array(repeating: Array(repeating: false, count: cols), count: rows)
        
        // Push all boundary cells into the priority queue and mark them as visited
        for r in 0..<rows {
            for c in 0..<cols {
                if r == 0 || r == rows - 1 || c == 0 || c == cols - 1 {
                    minHeap.append((heightMap[r][c], r, c))
                    visited[r][c] = true
                }
            }
        }
        
        // Convert the array to a heap
        minHeap.sort { $0.0 < $1.0 }
        
        // Directions for moving to neighboring cells (up, down, left, right)
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        
        var waterTrapped = 0
        
        // Process the cells in the priority queue
        while !minHeap.isEmpty {
            let (height, row, col) = minHeap.removeFirst()
            
            // Check all four neighboring cells
            for direction in directions {
                let newRow = row + direction.0
                let newCol = col + direction.1
                
                // If the neighboring cell is within bounds and not visited
                if newRow >= 0, newRow < rows, newCol >= 0, newCol < cols, !visited[newRow][newCol] {
                    // Calculate the water trapped at the neighboring cell
                    let newHeight = heightMap[newRow][newCol]
                    if height > newHeight {
                        waterTrapped += height - newHeight
                    }
                    
                    // Update the neighboring cell's height and mark it as visited
                    let updatedHeight = max(height, newHeight)
                    minHeap.append((updatedHeight, newRow, newCol))
                    visited[newRow][newCol] = true
                    
                    // Maintain the heap property
                    minHeap.sort { $0.0 < $1.0 }
                }
            }
        }
        
        return waterTrapped
    }
}