// Time Complexity: O(N1 + M1 + N2 + M2)
//   - N1, N2: number of nodes in graph1 and graph2 respectively.
//   - M1, M2: number of edges in graph1 and graph2 respectively.
//   - Building adjacency lists: O(N1 + M1) for graph1, O(N2 + M2) for graph2.
//   - Bipartitioning (DFS): O(N1 + M1) for graph1, O(N2 + M2) for graph2.
//   - Final mapping: O(N1).
// Space Complexity: O(N1 + M1 + N2 + M2)
//   - Adjacency lists: O(N1 + M1) for graph1, O(N2 + M2) for graph2.
//   - Sets for bipartition: O(N1) for graph1, O(N2) for graph2.
//   - Recursion stack for DFS: O(N1) for graph1, O(N2) for graph2 in worst case (e.g., a path graph).
//   - Result array: O(N1).
class Solution {
    /// Calculates a score for each node in the first graph based on graph bipartitions.
    ///
    /// For each node in graph1, the score is the size of the partition set it belongs to (in graph1's bipartition)
    /// plus the size of the larger partition set from graph2's bipartition.
    ///
    /// - Parameters:
    ///   - edgesForGraph1: An array of edges representing the first graph. Each edge is `[u, v]`.
    ///                     It's assumed this forms a connected graph (likely a tree).
    ///   - edgesForGraph2: An array of edges representing the second graph. Each edge is `[u, v]`.
    ///                     It's assumed this forms a connected graph (likely a tree).
    /// - Returns: An array of integers, where the i-th integer is the calculated score for node `i` from graph1.
    func maxTargetNodes(_ edgesForGraph1: [[Int]], _ edgesForGraph2: [[Int]]) -> [Int] {
        // Determine the number of nodes in each graph.
        // Nodes are assumed to be 0-indexed up to count_of_edges.
        let nodeCountGraph1 = edgesForGraph1.count + 1
        let nodeCountGraph2 = edgesForGraph2.count + 1

        // Build adjacency list representations for both graphs.
        let adjacencyListGraph1 = buildAdjacencyList(edgesForGraph1, nodeCount: nodeCountGraph1)
        let adjacencyListGraph2 = buildAdjacencyList(edgesForGraph2, nodeCount: nodeCountGraph2)

        // Perform a bipartition (2-coloring) of each graph.
        // This divides nodes into two sets such that no two nodes within the same set are adjacent.
        let bipartitionGraph1 = findBipartition(adjacencyListGraph1, nodeCount: nodeCountGraph1)
        let bipartitionGraph2 = findBipartition(adjacencyListGraph2, nodeCount: nodeCountGraph2)

        // Find the size of the larger set in graph2's bipartition.
        let maxNodesInOneSetGraph2 = max(bipartitionGraph2.setA.count, bipartitionGraph2.setB.count)

        // For each node in graph1, calculate its score.
        return Array(0..<nodeCountGraph1).map { nodeInGraph1 in
            // Determine the size of the partition set in graph1 that nodeInGraph1 belongs to.
            let nodesInSameSetAsCurrentNodeGraph1: Int
            if bipartitionGraph1.setA.contains(nodeInGraph1) {
                nodesInSameSetAsCurrentNodeGraph1 = bipartitionGraph1.setA.count
            } else {
                nodesInSameSetAsCurrentNodeGraph1 = bipartitionGraph1.setB.count
            }
            // The score is the sum of nodes in its own set in graph1 and the max set from graph2.
            return nodesInSameSetAsCurrentNodeGraph1 + maxNodesInOneSetGraph2
        }
    }

    /// Builds an adjacency list representation of a graph from its edges.
    ///
    /// - Parameters:
    ///   - edges: An array of pairs `[u, v]`, representing an edge between node u and node v.
    ///   - nodeCount: The total number of nodes in the graph. Nodes are 0-indexed.
    /// - Returns: An array of sets, where the i-th set contains the neighbors of node `i`.
    private func buildAdjacencyList(_ edges: [[Int]], nodeCount: Int) -> [Set<Int>] {
        // Initialize an empty adjacency list for each node.
        var adjacencyList: [Set<Int>] = Array(repeating: [], count: nodeCount)
        // Populate the adjacency list from the edges.
        for edge in edges {
            let u = edge[0]
            let v = edge[1]
            // Add undirected edges.
            adjacencyList[u].insert(v)
            adjacencyList[v].insert(u)
        }
        return adjacencyList
    }

    /// Finds a bipartition of a graph using Depth First Search (DFS).
    /// Assumes the graph is connected and bipartite (e.g., a tree).
    /// If the graph is not connected, it only processes the component containing node 0.
    ///
    /// - Parameters:
    ///   - adjacencyList: The graph represented as an adjacency list.
    ///   - nodeCount: The total number of nodes in the graph.
    /// - Returns: A tuple containing two sets, `setA` and `setB`, representing the bipartition.
    private func findBipartition(_ adjacencyList: [Set<Int>], nodeCount: Int) -> (setA: Set<Int>, setB: Set<Int>) {
        var setA: Set<Int> = []
        var setB: Set<Int> = []
        var visited: Set<Int> = [] // Keep track of visited nodes to handle graphs (even if trees are expected)

        /// Recursive DFS helper function to assign nodes to partition sets.
        func dfs(_ parentNode: Int?, _ currentNode: Int, _ assignToSetA: Bool) {
            visited.insert(currentNode) // Mark current node as visited.

            // Assign the current node to the appropriate set based on 'assignToSetA'.
            if assignToSetA {
                setA.insert(currentNode)
            } else {
                setB.insert(currentNode)
            }

            // Visit all unvisited neighbors.
            for neighborNode in adjacencyList[currentNode] {
                // Avoid going back to the parent immediately in a tree-like traversal.
                // For general graphs, checking 'visited' is more robust.
                if neighborNode != parentNode && !visited.contains(neighborNode) {
                     // Assign the neighbor to the other set.
                    dfs(currentNode, neighborNode, !assignToSetA)
                }
            }
        }
        
        // Start DFS from node 0, assigning it to setA initially.
        // This assumes node 0 exists and the graph (or its relevant component) is reachable from node 0.
        if nodeCount > 0 && !adjacencyList.isEmpty { // Ensure graph is not empty
            dfs(nil, 0, true)
        }
        
        return (setA, setB)
    }
}