class Solution {
    func closestMeetingNode(_ edges: [Int], _ node1: Int, _ node2: Int) -> Int {
        var graph = [Int: [Int]]()
        
        for (index, edge) in edges.enumerated() {
            if edge == -1 { continue }
            
            graph[index, default: []].append(edge)
        }

        func bfs(_ node: Int) -> [Int] {
            var queue = [(node: node, path: 0)]
            var distances = Array(repeating: Int.max, count: edges.count)
            var visited = Set<Int>()
            visited.insert(node)
            
            while queue.isEmpty == false {
                let lastElement = queue.removeLast()
                let node = lastElement.node
                let path = lastElement.path
                
                for neighbour in graph[node] ?? [] {
                    if visited.contains(neighbour) { continue }
                    
                    queue.insert((node: neighbour, path: path + 1), at: 0)
                    visited.insert(neighbour)
                    distances[neighbour] = path + 1
                }
            }
            
            return distances
        }

        var distances1 = bfs(node1)
        var distances2 = bfs(node2)

        // distances to self
        distances1[node1] = 0
        distances2[node2] = 0

        var minDistance = Int.max
        var minDistanceIndex = -1

        for index in 0..<edges.count {
            let maxDistance = max(distances1[index], distances2[index])
            
            if maxDistance < minDistance {
                minDistance = maxDistance
                minDistanceIndex = index
            }

        }
        
        return minDistanceIndex
    }
}