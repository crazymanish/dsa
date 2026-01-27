class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O((n + m) log n)
    ///     - n = number of nodes
    ///     - m = number of edges
    ///     Dijkstra’s algorithm with a min-heap.
    ///
    /// Space Complexity:
    ///   • O(n + m)
    ///     - Graph adjacency list
    ///     - Distance array, visited flags, heap
    ///
    /// Problem Summary:
    ///   Given an undirected graph with weighted edges:
    ///     - Traversing an edge in the given direction costs `w`
    ///     - Traversing it in reverse costs `2 * w`
    ///
    ///   Find the minimum cost to travel from node 0 to node n-1.
    ///
    /// Approach:
    ///   - Build a directed weighted graph:
    ///       u -> v with cost w
    ///       v -> u with cost 2w
    ///   - Run Dijkstra’s algorithm from node 0.
    ///   - Use a min-heap where (distance, node) is packed into one integer
    ///     for efficiency.
    /// -----------------------------------------------------------------------
    func minCost(_ n: Int, _ edges: [[Int]]) -> Int {
        
        // Build adjacency list:
        // graph[u] = [(v, cost)]
        let adjacencyList = edges.reduce(
            into: [Int: [(neighbor: Int, cost: Int)]]()
        ) { graph, edge in
            let u = edge[0]
            let v = edge[1]
            let w = edge[2]
            
            graph[u, default: []].append((v, w))
            graph[v, default: []].append((u, w * 2))
        }
        
        // Track visited nodes (to finalize shortest distances)
        var visited = BitArray(repeating: false, count: n)
        
        // dist[i] = shortest distance from node 0 to node i
        var distances = Array(repeating: Int.max, count: n)
        distances[0] = 0
        
        // Min-heap storing packed (distance << 16 | node)
        // Lower distance has higher priority
        var minHeap = Heap([0])   // (0 << 16) | 0
        
        while let packedValue = minHeap.popMin() {
            // Extract node index (lower 16 bits)
            let currentNode = packedValue & 0xffff
            
            // Skip if already finalized
            if visited[currentNode] { continue }
            visited[currentNode] = true
            
            // Relax edges
            for (neighbor, cost) in adjacencyList[currentNode] ?? [] {
                let newDistance = distances[currentNode] + cost
                if newDistance < distances[neighbor] {
                    distances[neighbor] = newDistance
                    
                    // Pack distance and node into one integer
                    let packed = (newDistance << 16) | neighbor
                    minHeap.insert(packed)
                }
            }
        }
        
        // If destination is unreachable, return -1
        return distances[n - 1] == .max ? -1 : distances[n - 1]
    }
}
