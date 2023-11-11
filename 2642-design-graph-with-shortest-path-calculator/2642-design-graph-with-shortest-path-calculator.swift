class Graph {
    private var graph: [[(Int, Int)]]
    
    init(_ n: Int, _ edges: [[Int]]) {
        graph = [[(Int, Int)]](repeating: [], count: n)
        
        for edge in edges { 
            addEdge(edge) 
        }
    }
    
    func addEdge(_ edge: [Int]) {
        let (from, to, edgeCost) = (edge[0], edge[1], edge[2])
        graph[from].append((to, edgeCost))
    }
    
    func shortestPath(_ node1: Int, _ node2: Int) -> Int {
        var dist = [Int](repeating: Int.max, count: graph.count)
        dist[node1] = 0

        var minHeap = [(Int, Int)]()
        minHeap.append((dist[node1], node1))
        
        while !minHeap.isEmpty {
            let (d, u) = minHeap.removeFirst()
            if u == node2 { return d }

            for (v, w) in graph[u] {
                if d + w < dist[v] {
                    dist[v] = d + w
                    minHeap.append((dist[v], v))
                }
            }
            
            minHeap.sort { $0.0 < $1.0 }
        }
        
        return -1
    }
}

/**
 * Your Graph object will be instantiated and called as such:
 * let obj = Graph(n, edges)
 * obj.addEdge(edge)
 * let ret_2: Int = obj.shortestPath(node1, node2)
 */