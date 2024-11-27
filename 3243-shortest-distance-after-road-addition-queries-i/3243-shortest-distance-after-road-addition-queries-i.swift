class Solution {
    func shortestDistanceAfterQueries(_ n: Int, _ queries: [[Int]]) -> [Int] {
        var graph = Array(repeating: [Int](), count: n)
        for i in 0..<n { graph[i].append(i + 1) }
        var result = Array(repeating: n - 1, count: queries.count)
        
        func bfs() -> Int {
            var res = 0
            var queue = [0]
            var visited: Set<Int> = [0]
            
            while !queue.isEmpty {
                var newQueue: [Int] = []
                for q in queue {
                    if q == n - 1 { return res }
                    for neigh in graph[q] {
                        if visited.contains(neigh) { continue }
                        
                        visited.insert(neigh)
                        newQueue.append(neigh)
                    }
                }
                queue = newQueue
                res += 1
            }
            
            return res
        }
        
        for (i, q) in queries.enumerated() {
            guard q[1] - q[0] > 1 else {
                if i > 0 { result[i] = result[i - 1] }
                continue
            }
            
            graph[q[0]].append(q[1])
            result[i] = bfs()
        }
        
        return result
    }
}