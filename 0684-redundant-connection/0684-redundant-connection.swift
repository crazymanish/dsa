class Solution {
    // Union-Find data structure to detect cycles
    class UnionFind {
        // Parent array where each index represents a vertex
        private var parent: [Int]
        
        init(_ size: Int) {
            // Initialize parent array with each vertex as its own parent
            parent = Array(0...size)
        }
        
        // Find the root parent of a vertex with path compression
        func find(_ x: Int) -> Int {
            if parent[x] != x {
                parent[x] = find(parent[x])  // Path compression
            }
            return parent[x]
        }
        
        // Union two vertices by setting one's parent as the other's root
        func union(_ x: Int, _ y: Int) {
            parent[find(x)] = find(y)
        }
        
        // Check if two vertices are connected (have same root)
        func connected(_ x: Int, _ y: Int) -> Bool {
            return find(x) == find(y)
        }
    }
    
    func findRedundantConnection(_ edges: [[Int]]) -> [Int] {
        // Create UnionFind instance with size equal to number of vertices
        let uf = UnionFind(edges.count)
        
        // Process each edge
        for edge in edges {
            let u = edge[0]
            let v = edge[1]
            
            // If vertices are already connected, we found a cycle
            if uf.connected(u, v) {
                return edge
            }
            
            // Otherwise, union the vertices
            uf.union(u, v)
        }
        
        return []  // No redundant connection found
    }
}