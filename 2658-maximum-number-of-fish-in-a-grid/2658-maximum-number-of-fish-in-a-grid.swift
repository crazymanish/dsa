class Solution {
    func findMaxFish(_ grid: [[Int]]) -> Int {
        // Get the dimensions of the grid
        let (rows, cols) = (grid.count, grid[0].count)
        // Create a mutable copy of the grid
        var grid = grid
        // Variable to track the maximum number of fish collected
        var maxFishCollected = 0
        
        // Iterate through each cell in the grid
        for row in 0..<rows {
            for col in 0..<cols {
                // If the cell has no fish, skip it
                if grid[row][col] == 0 { continue }
                // Perform DFS from the current cell and update maxFishCollected
                maxFishCollected = max(maxFishCollected, collectFish(row, col))
            }
        }
        
        return maxFishCollected

        // DFS function to collect fish from the grid
        func collectFish(_ row: Int, _ col: Int) -> Int {
            // Collect fish from the current cell
            var totalFish = grid[row][col]
            // Mark the current cell as visited by setting it to 0
            grid[row][col] = 0
            // Directions for moving up, down, left, right
            let directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]
            
            // Explore all adjacent cells
            for (dr, dc) in directions {
                let (newRow, newCol) = (row + dr, col + dc)
                // Check if the adjacent cell is within bounds and has fish
                if newRow < 0 || newRow >= rows || newCol < 0 || newCol >= cols || grid[newRow][newCol] == 0 { continue }
                // Recursively collect fish from the adjacent cell
                totalFish += collectFish(newRow, newCol)
            }
            
            return totalFish
        }
    }
}