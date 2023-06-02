class Solution {
    func maximumDetonation(_ bombs: [[Int]]) -> Int {
        func isReachable(_ source: Int, _ target: Int) -> Bool {
            let bombSource = bombs[source]
            let bombTarget = bombs[target]
            let bombDiffX = bombSource[0] - bombTarget[0]
            let bombDiffY = bombSource[1] - bombTarget[1]
            let bombRadius = bombSource[2]

            return bombRadius * bombRadius >= bombDiffX * bombDiffX + bombDiffY * bombDiffY
        }
        
        func bfs(_ currentBomb: Int) -> Int {
            var count = 1
            var queue = [Int]()
            queue.append(currentBomb)
            
            var visited = Array(repeating: false, count: bombs.count)
            visited[currentBomb] = true

            while queue.isEmpty == false {
                let sourceBomb = queue.removeFirst()            
                for targetBomb in 0..<bombs.count {
                    if visited[targetBomb] == false && isReachable(sourceBomb, targetBomb) {
                        queue.append(targetBomb)
                        visited[targetBomb] = true
                        count += 1 
                    }
                }
            }

            return count
        }
        
        
        var maximumDetonationCount = 1
        for currentBomb in 0..<bombs.count {
            let currentDetonationCount = bfs(currentBomb)
            maximumDetonationCount = max(maximumDetonationCount, currentDetonationCount)
        }
        
        return maximumDetonationCount
    }
}