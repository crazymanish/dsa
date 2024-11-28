class Solution {
    func minimumObstacles(_ grid: [[Int]]) -> Int {
        let m = grid.count
        let n = grid[0].count
        
        // Directions: right, down, left, up
        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        
        // Distance/obstacles removed array
        var dist = Array(repeating: Array(repeating: Int.max, count: n), count: m)
        dist[0][0] = 0
        
        // Use a deque (double-ended queue) to simulate 0-1 BFS
        var deque = Deque<(Int, Int, Int)>() // (obstacles, row, col)
        deque.pushFront((0, 0, 0))
        
        while !deque.isEmpty {
            let (obstacles, row, col) = deque.popFront()
            
            // Skip if already processed with fewer obstacles
            if obstacles > dist[row][col] {
                continue
            }
            
            // Reached bottom-right corner
            if row == m - 1 && col == n - 1 {
                return obstacles
            }
            
            // Explore 4 directions
            for (dx, dy) in directions {
                let newRow = row + dx
                let newCol = col + dy
                
                // Check bounds
                guard newRow >= 0 && newRow < m && 
                      newCol >= 0 && newCol < n else {
                    continue
                }
                
                // Calculate new obstacles count
                let newObstacles = obstacles + (grid[newRow][newCol] == 1 ? 1 : 0)
                
                // Update if we found a better path
                if newObstacles < dist[newRow][newCol] {
                    dist[newRow][newCol] = newObstacles
                    
                    // Use deque's push methods to optimize BFS
                    if grid[newRow][newCol] == 1 {
                        // Obstacle cell: push to back (higher priority)
                        deque.pushBack((newObstacles, newRow, newCol))
                    } else {
                        // Empty cell: push to front (lower priority)
                        deque.pushFront((newObstacles, newRow, newCol))
                    }
                }
            }
        }
        
        // Should never reach here given the problem constraints
        return -1
    }
}

class Deque<T> {
    private var front: [T] = []
    private var back: [T] = []
    
    var isEmpty: Bool {
        return front.isEmpty && back.isEmpty
    }
    
    func pushFront(_ element: T) {
        front.append(element)
    }
    
    func pushBack(_ element: T) {
        back.insert(element, at: 0)
    }
    
    func popFront() -> T {
        if front.isEmpty {
            front = back.reversed()
            back.removeAll()
        }
        return front.removeLast()
    }
}