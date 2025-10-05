// Time Complexity: O(M * N)
// The runtime is dominated by the two BFS traversals. Each BFS visits every cell
// at most once. Since there are M*N cells, the complexity is linear with respect
// to the number of cells in the matrix.
// NOTE: This implementation uses `removeFirst()` on an Array to simulate a queue,
// which is an O(K) operation (where K is queue size). A dedicated Queue data
// structure with an O(1) dequeue is more performant for BFS.
//
// Space Complexity: O(M * N)
// We use two `visited` matrices of size M*N. The BFS queues can also grow to
// the size of the matrix in the worst case, requiring O(M*N) space.
class Solution {
    func pacificAtlantic(_ matrix: [[Int]]) -> [[Int]] {
        // Handle edge case for an empty or invalid matrix.
        guard !matrix.isEmpty, !matrix[0].isEmpty else {
            return [] // Return an empty list of coordinates.
        }
        
        let rows = matrix.count
        let columns = matrix[0].count
        
        var result = [[Int]]()
        // `pacificVisited` tracks all cells that can eventually flow to the Pacific.
        var pacificVisited = Array(repeating: Array(repeating: false, count: columns), count:rows)
        // `atlanticVisited` tracks all cells that can eventually flow to the Atlantic.
        var atlanticVisited = Array(repeating: Array(repeating: false, count: columns), count: rows)
        
        var pacificQueue: [[Int]] = []
        var atlanticQueue: [[Int]] = []
        
        // Initialize the queues with all cells directly touching the oceans. These are
        // our starting points for the BFS traversals.
        for row in 0..<rows {
            // Left edge (Pacific)
            pacificQueue.append([row, 0])
            pacificVisited[row][0] = true
            // Right edge (Atlantic)
            atlanticQueue.append([row, columns-1])
            atlanticVisited[row][columns-1] = true
        }
        
        for column in 0..<columns {
            // Top edge (Pacific)
            pacificQueue.append([0, column])
            pacificVisited[0][column] = true
            // Bottom edge (Atlantic)
            atlanticQueue.append([rows-1, column])
            atlanticVisited[rows-1][column] = true
        }
        
        // Nested helper function to perform BFS from ocean cells inland.
        // It captures outer scope variables like `rows`, `columns`, and `matrix`.
        func BFS(_ queue: [[Int]], _ visited: inout [[Bool]]) {
            let directions = [[1, 0], [-1, 0], [0, 1], [0, -1]]
            // Create a mutable copy of the initial queue to process.
            var queue = queue
        
            while !queue.isEmpty {
                let current = queue.removeFirst()
                for direction in directions {
                    let x = current[0] + direction[0]
                    let y = current[1] + direction[1]

                    // The main condition for continuing the search:
                    // 1. Stay within grid bounds.
                    // 2. Don't visit a cell more than once.
                    // 3. The neighbor's height must be >= current cell's height (reverse flow).
                    if x < 0 || x >= rows || y < 0 || y >= columns || visited[x][y] || matrix[x][y] < matrix[current[0]][current[1]] {
                        continue
                    }
                    
                    visited[x][y] = true
                    queue.append([x, y])
                }
            }
        }
        
        // Run the BFS for both oceans.
        BFS(pacificQueue, &pacificVisited)
        BFS(atlanticQueue, &atlanticVisited)
        
        // Find the intersection: cells that can reach both oceans.
        for row in 0..<rows {
            for column in 0..<columns {
                if pacificVisited[row][column] && atlanticVisited[row][column] {
                    result.append([row, column])
                }
            }
        }
        
        return result
    }
}