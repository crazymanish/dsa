class Solution {
    func shortestPath(_ grid: [[Int]], _ k: Int) -> Int {
        let rows = grid.count
        let columns = grid[0].count
        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        
        var seen = Array(repeating: Array(repeating: Int.max, count: columns), count: rows)
        seen[0][0] = 0
        
        var queue = [(Int, Int, Int)]()
        queue.append((0, 0, 0))
        
        var steps = 0
        while !queue.isEmpty {
            let count = queue.count
            for i in 0..<count {
                var (x, y, obs) = queue.removeFirst()
                if x == rows-1 && y == columns-1 { return steps }
                
                for direction in directions {
                    var currentX = x + direction.0
                    var currentY = y + direction.1
                    if currentX >= 0 && currentX < rows && currentY >= 0 && currentY < columns {
                        let obstcle = obs + grid[currentX][currentY]
                        if obstcle >= seen[currentX][currentY] || obstcle > k  { 
                            continue 
                        } else { 
                            seen[currentX][currentY] = obstcle
                            queue.append((currentX, currentY, obstcle))
                        }
                    } 
                }
            }
            
            steps += 1
        }
        
        return -1
    }
}