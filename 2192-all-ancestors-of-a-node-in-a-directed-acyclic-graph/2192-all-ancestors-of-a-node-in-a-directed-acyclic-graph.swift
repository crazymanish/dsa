class Solution {
    func getAncestors(_ n: Int, _ edges: [[Int]]) -> [[Int]] {
        var ancestors = Array(repeating: Set<Int>?.none, count: n)

        // Build the adjacency list. Note that we reverse the edges.
        // The descendants in the reversed graph are the ancestors in the original one.
        var adj = Array(repeating: [Int](), count: n)
        for edge in edges {
            adj[edge[1]].append(edge[0])
        }

        func visit(_ i: Int) {
            // Use the cached result if known. 
            if let result = ancestors[i] { return } 

            ancestors[i] = []

            // For each neighbor, compute its ancestors and add them to the ancestors of the node.
            for v in adj[i] {
                ancestors[i]!.insert(v)
                visit(v)
                ancestors[i] = ancestors[i]!.union(ancestors[v]!)
            }
        }

        // Visit all nodes.
        for i in 0..<n { visit(i) }

        // Map the sets to sorted arrays as required.
        return ancestors.map { Array($0!).sorted() }
    }
}