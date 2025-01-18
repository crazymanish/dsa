import Collections

class Solution {
    func minCost(_ grid: [[Int]]) -> Int {
        // Number of rows and columns in the grid
        let (rows, cols) = (grid.count, grid[0].count)
        
        // Directions: 1->right, 2->left, 3->down, 4->up
        // Stored as [dy, dx] to access grid[y+dy][x+dx]
        let dirs = [
            [0, 1],   // right
            [0, -1],  // left
            [1, 0],   // down
            [-1, 0]   // up
        ]
        
        // minCost[y][x] will track the minimum cost to reach (x,y)
        var minCost = Array(
            repeating: [Int](repeating: Int.max, count: cols),
            count: rows
        )
        
        // Starting cell's cost is zero
        minCost[0][0] = 0
        
        // Deque from Collections framework to facilitate 0-1 BFS
        // Initialize with the starting position (0,0)
        var deque: Deque = [(0, 0)]
        
        // Process the queue until all reachable cells have minimal costs
        while let (x, y) = deque.popFirst() {
            
            // Explore all four possible directions (1..4)
            for dir in 1...4 {
                // Compute the next coordinates based on dir
                let (xNext, yNext) = (x + dirs[dir - 1][1], y + dirs[dir - 1][0])
                
                // cost = 0 if moving in the cell's preferred direction,
                // otherwise cost = 1
                let moveCost = (grid[y][x] == dir) ? 0 : 1
                
                // Potential new cost to reach (xNext, yNext)
                let newCost = minCost[y][x] + moveCost
                
                // Check boundaries and see if we found a cheaper path
                guard
                    yNext >= 0, yNext < rows,
                    xNext >= 0, xNext < cols,
                    newCost < minCost[yNext][xNext]
                else {
                    continue
                }
                
                // Update minCost to reflect the cheaper path
                minCost[yNext][xNext] = newCost
                
                // 0 cost moves get added to the front; 1 cost moves to the back
                if moveCost == 1 {
                    // Used a different direction => costlier
                    deque.append((xNext, yNext))
                } else {
                    // Used the cell's preferred direction => no additional cost
                    deque.prepend((xNext, yNext))
                }
            }
        }
        
        // The minimum cost to reach the bottom-right cell
        return minCost[rows - 1][cols - 1]
    }
}