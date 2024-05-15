class Solution {
    func maximumSafenessFactor(_ grid: [[Int]]) -> Int {
        let n = grid.count
        var distance = Array(repeating: Array(repeating: Int.max, count: n), count: n)
        
        // Step 1: Identify thief positions and initialize queue for BFS
        var queue: [(Int, Int)] = []
        for r in 0..<n {
            for c in 0..<n {
                if grid[r][c] == 1 {
                    queue.append((r, c))
                    distance[r][c] = 0
                }
            }
        }
        
        // Step 2: Calculate minimum Manhattan distances using BFS
        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        var index = 0
        while index < queue.count {
            let (r, c) = queue[index]
            index += 1
            for (dr, dc) in directions {
                let nr = r + dr, nc = c + dc
                if nr >= 0 && nr < n && nc >= 0 && nc < n {
                    if distance[nr][nc] > distance[r][c] + 1 {
                        distance[nr][nc] = distance[r][c] + 1
                        queue.append((nr, nc))
                    }
                }
            }
        }
        
        // Step 3: Use Dijkstra's algorithm to find the path that maximizes the safeness factor
        var safenessFactor = Array(repeating: Array(repeating: Int.min, count: n), count: n)
        var maxHeap = [(safeness: Int, r: Int, c: Int)]()
        
        safenessFactor[0][0] = distance[0][0]
        maxHeap.append((safeness: safenessFactor[0][0], r: 0, c: 0))
        
        while !maxHeap.isEmpty {
            maxHeap.sort { $0.safeness > $1.safeness }
            let (currentSafeness, r, c) = maxHeap.removeFirst()
            
            for (dr, dc) in directions {
                let nr = r + dr, nc = c + dc
                if nr >= 0 && nr < n && nc >= 0 && nc < n {
                    let newSafeness = min(currentSafeness, distance[nr][nc])
                    if newSafeness > safenessFactor[nr][nc] {
                        safenessFactor[nr][nc] = newSafeness
                        maxHeap.append((safeness: newSafeness, r: nr, c: nc))
                    }
                }
            }
        }
        
        return safenessFactor[n - 1][n - 1]
    }
}