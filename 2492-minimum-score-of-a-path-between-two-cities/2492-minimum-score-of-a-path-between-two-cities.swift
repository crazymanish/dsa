class Solution {
    func minScore(_ n: Int, _ roads: [[Int]]) -> Int {
        var minWeight = Int.max
        var adjacencyList = Array(repeating: [Path](), count: n + 1)
        for road in roads {
            adjacencyList[road[0]].append(Path(edge: road[1], weight: road[2]))
            adjacencyList[road[1]].append(Path(edge: road[0], weight: road[2]))
        }
        
        var queue: [Int] = []
        var visited = Set<Int>()
        visited.insert(1)
        queue.append(1)
        
        while queue.count > 0 {
            let edge = queue.removeFirst()
            let paths = adjacencyList[edge]
            
            for path in paths {
                minWeight = min(minWeight, path.weight)
                
                if visited.contains(path.edge) == false {
                    visited.insert(path.edge)
                    queue.append(path.edge)
                }
            }
        }
        
        return minWeight
    }
}

extension Solution {
    struct Path {
        var edge: Int
        var weight: Int
    } 
}