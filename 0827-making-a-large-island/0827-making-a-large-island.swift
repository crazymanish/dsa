import Foundation

class Solution {
    // Directions for moving in the grid (up, down, left, right)
    private let directions: [[Int]] = [[-1, 0], [0, -1], [0, 1], [1, 0]]

    func largestIsland(_ grid: [[Int]]) -> Int {
        var grid = grid
        
        // Function to check if a cell is within the grid boundaries
        func isValidCell(_ row: Int, _ col: Int) -> Bool {
            return grid.indices ~= row && grid[0].indices ~= col
        }

        // Dictionary to store the area of each island identified by its color
        var islandAreaMap: [Int: Int] = [:]
        islandAreaMap[0] = 0  // Initialize the area for color 0 (water) as 0
        var currentColor = 2  // Start island IDs from 2 to avoid confusion with 0 and 1

        // DFS function to label islands and calculate their area
        func dfs(_ row: Int, _ col: Int) -> Int {
            grid[row][col] = currentColor  // Label the current cell with the current color
            var area = 1  // Initialize the area of the current island
            for direction in directions {
                let newRow = row + direction[0]
                let newCol = col + direction[1]
                if isValidCell(newRow, newCol) && grid[newRow][newCol] == 1 {
                    area += dfs(newRow, newCol)  // Recursively calculate the area
                }
            }
            return area
        }

        // Label each island with a unique color and calculate its area
        for row in grid.indices {
            for col in grid[0].indices where grid[row][col] == 1 {
                islandAreaMap[currentColor] = dfs(row, col)
                currentColor += 1
            }
        }

        // If there are no islands, return 1 (since we can change one 0 to 1)
        guard var maxIslandSize = islandAreaMap[2] else { return 1 }

        // Check each zero to see the potential island size if changed to one
        for row in grid.indices {
            for col in grid[0].indices where grid[row][col] == 0 {
                var neighboringColors: Set<Int> = []
                for direction in directions {
                    let newRow = row + direction[0]
                    let newCol = col + direction[1]
                    if isValidCell(newRow, newCol) {
                        neighboringColors.insert(grid[newRow][newCol])
                    }
                }
                var potentialIslandSize = 1  // Start with 1 for the current zero being changed to one
                for color in neighboringColors {
                    potentialIslandSize += islandAreaMap[color] ?? 0
                }
                maxIslandSize = max(maxIslandSize, potentialIslandSize)
            }
        }
        return maxIslandSize
    }
}
