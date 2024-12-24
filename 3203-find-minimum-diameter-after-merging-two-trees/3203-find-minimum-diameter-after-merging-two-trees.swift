class Solution {
    func minimumDiameterAfterMerge(_ e1: [[Int]], _ e2: [[Int]]) -> Int {
        func diameter(_ edges: [[Int]]) -> Int {
            // Number of nodes is edges.count + 1
            let m = edges.count + 1
            var res = 0
    
            // Adjacency list for the graph
            var adjacencyList = [[Int]](repeating: [], count: m)
            // Arrays for degree, depth, and visited status
            var degree = [Int](repeating: 0, count: m)
            var depth = [Int](repeating: 0, count: m)
            var visited = [Bool](repeating: false, count: m)
    
            // Queue to process leaf nodes
            var queue = [Int]()
    
            // Build the adjacency list
            for edge in edges {
                adjacencyList[edge[0]].append(edge[1])
                adjacencyList[edge[1]].append(edge[0])
            }
    
            // Initialize degrees and add leaves (degree == 1) to queue
            for i in 0..<m {
                degree[i] = adjacencyList[i].count
                if degree[i] == 1 {
                    queue.append(i)
                }
            }
    
            // Process nodes from the queue (similar to topological/breadth-first approach)
            var index = 0
            while index < queue.count {
                let node = queue[index]
                index += 1
        
                visited[node] = true
                // Process neighbors
                for neighbor in adjacencyList[node] {
                    degree[neighbor] -= 1
                    if degree[neighbor] == 1 {
                        queue.append(neighbor)
                    }
                    if !visited[neighbor] {
                        // Update the result (max distance so far)
                        res = max(res, depth[neighbor] + depth[node] + 1)
                        // Update the depth of the neighbor
                        depth[neighbor] = max(depth[neighbor], depth[node] + 1)
                    }
                }
            }
    
            return res
        }
        
        let d1 = diameter(e1)
        let d2 = diameter(e2)
    
        // Combine results considering each tree's diameter and the merged midpoint
        return max(d1, d2, (d1 + 1) / 2 + (d2 + 1) / 2 + 1)
    }
}