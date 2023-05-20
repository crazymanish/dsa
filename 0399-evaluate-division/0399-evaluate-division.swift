class Solution {
    func calcEquation(_ equations: [[String]], _ values: [Double], _ queries: [[String]]) -> [Double] {
        let graph = zip(equations, values).reduce(into: [String: [String: Double]]()) { graph, tuple in
            let (start, end, weight) = (tuple.0[0], tuple.0[1], tuple.1)
                                                                                      
            graph[start, default:[:]][end] = weight
            graph[end, default:[:]][start] = 1.0 / weight
        }

        func bfs(_ query:[String]) -> Double {
            let (start, end) = (query[0], query[1])
            
            guard graph[start] != nil, graph[end] != nil else { return -1.0 }
            guard start != end else { return 1.0 }
            
            var queue = [(start, 1.0)]
            var visited = Set([start])
            
            while !queue.isEmpty {
                let (node, weight) = queue.removeLast()
                
                for (adjacentNode, adjacentWeight) in graph[node]! where !visited.contains(adjacentNode) {
                    guard adjacentNode != end else { return weight * adjacentWeight }
                    
                    queue.append((adjacentNode, weight * adjacentWeight))
                    visited.insert(adjacentNode)
                }
            }
            
            return -1.0
        }

        return queries.map(bfs)
    }
}