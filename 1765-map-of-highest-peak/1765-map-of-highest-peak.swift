class Solution {
    func highestPeak(_ isWater: [[Int]]) -> [[Int]] {
        let rows = isWater.count
        let cols = isWater[0].count
        
        // Initialize the result grid with -1 (unvisited)
        var heights = Array(repeating: Array(repeating: -1, count: cols), count: rows)
        var queue = [(Int, Int)]()
        
        // Directions for moving up, down, left, right
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        
        // Enqueue all water cells and set their height to 0
        for r in 0..<rows {
            for c in 0..<cols {
                if isWater[r][c] == 1 {
                    heights[r][c] = 0
                    queue.append((r, c))
                }
            }
        }
        
        // BFS to propagate heights
        var index = 0
        while index < queue.count {
            let (r, c) = queue[index]
            index += 1
            for (dr, dc) in directions {
                let nr = r + dr
                let nc = c + dc
                // Check bounds and if the cell is unvisited
                if nr >= 0, nr < rows, nc >= 0, nc < cols, heights[nr][nc] == -1 {
                    heights[nr][nc] = heights[r][c] + 1
                    queue.append((nr, nc))
                }
            }
        }
        
        return heights
    }
}