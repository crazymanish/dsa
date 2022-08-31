class Solution {
    func pacificAtlantic(_ matrix: [[Int]]) -> [[Int]] {
        if matrix.count == 0 || matrix[0].count == 0 {
            return [[]]
        }
        
        let rows = matrix.count
        let columns = matrix[0].count
        
        var result = [[Int]]()
        var pacificVisited = Array(repeatElement(Array(repeatElement(false, count: columns)), count:rows))
        var atlanticVisited = Array(repeatElement(Array(repeatElement(false, count: columns)), count: rows))
        var pacificQueue = [[Int]]()
        var atlanticQueue = [[Int]]()
        
        for row in 0..<rows {
            pacificQueue.append([row, 0])
            atlanticQueue.append([row, columns-1])
            
            pacificVisited[row][0] = true
            atlanticVisited[row][columns-1] = true
        }
        
        for column in 0..<columns {
            pacificQueue.append([0, column])
            atlanticQueue.append([rows-1, column])
            
            pacificVisited[0][column] = true
            atlanticVisited[rows-1][column] = true
        }
        
        BFS(pacificQueue, &pacificVisited)
        BFS(atlanticQueue, &atlanticVisited)
        
        for row in 0..<rows {
            for column in 0..<columns {
                if pacificVisited[row][column] && atlanticVisited[row][column] {
                    result.append([row, column])
                }
            }
        }
        
        func BFS(_ queue: [[Int]], _ visited: inout [[Bool]]) {
            let directions = [[1, 0], [-1, 0], [0, 1], [0, -1]]
            var queue = queue
        
            while !queue.isEmpty {
                let current = queue.removeFirst()
                for direction in directions {
                    let x = current[0] + direction[0]
                    let y = current[1] + direction[1]
                    if x < 0 || x >= rows || y < 0 || y >= columns || visited[x][y] || matrix[x][y] < matrix[current[0]][current[1]] {
                        continue
                    }
                    visited[x][y] = true
                    queue.append([x, y])
                }
            }
        }
        
        return result
    }
}

/*
    func pacificAtlantic_DFS(_ matrix: [[Int]]) -> [[Int]] {
        if matrix.count == 0 || matrix[0].count == 0 {
            return [[Int]]()
        }
        
        let n = matrix.count
        let m = matrix[0].count
        var result = [[Int]]()
        var pacific = [[Bool]](repeatElement([Bool](repeatElement(false, count: m)), count: n))
        var atlantic = [[Bool]](repeatElement([Bool](repeatElement(false, count: m)), count: n))
        
        for i in 0..<n {
            DFS(matrix, Int.min, i, 0, &pacific)
            DFS(matrix, Int.min, i, m - 1, &atlantic)
        }
        for i in 0..<m {
            DFS(matrix, Int.min, 0, i, &pacific)
            DFS(matrix, Int.min, n - 1, i, &atlantic)
        }
        for i in 0..<n {
            for j in 0..<m {
                if pacific[i][j] && atlantic[i][j] {
                    result.append([i, j])
                }
            }
        }
        
        return result
    }
    
    private func DFS(_ matrix: [[Int]], _ height: Int, _ x: Int, _ y: Int, _ visited: inout [[Bool]]) {
        let n = matrix.count
        let m = matrix[0].count
        if x < 0 || x >= n || y < 0 || y >= m || visited[x][y] || matrix[x][y] < height {
            return
        }
        visited[x][y] = true
        for direction in self.directions {
            DFS(matrix, matrix[x][y], x + direction[0], y + direction[1], &visited)
        }
    }
*/
