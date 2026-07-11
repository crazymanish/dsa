class Solution {
    /**
     Problem Summary:
     Count the connected components in an undirected graph where every pair of
     nodes within each component is directly connected.

     Strategy:
     1. Build an adjacency list using sets of neighboring nodes.
     2. Use depth-first search to collect every node in each connected component.
     3. A component containing `k` nodes is complete when every node has exactly
        `k - 1` neighbors.

     Time Complexity:
     O(V + E), where V is `nodeCount` and E is the number of edges.

     Space Complexity:
     O(V + E) for the adjacency list, visited set, component nodes, and recursion stack.
     */
    func countCompleteComponents(_ nodeCount: Int, _ edgeList: [[Int]]) -> Int {
        var adjacencyList = [Int: Set<Int>]()

        // Build the undirected graph.
        for edge in edgeList {
            let firstNode = edge[0]
            let secondNode = edge[1]

            adjacencyList[firstNode, default: []].insert(secondNode)
            adjacencyList[secondNode, default: []].insert(firstNode)
        }

        var visitedNodes = Set<Int>()
        var completeComponentCount = 0

        // Collect all nodes belonging to the current connected component.
        func collectComponentNodes(
            from currentNode: Int,
            into componentNodes: inout [Int]) {
            visitedNodes.insert(currentNode)
            componentNodes.append(currentNode)

            for neighborNode in adjacencyList[currentNode, default: []] {
                guard !visitedNodes.contains(neighborNode) else {
                    continue
                }

                collectComponentNodes(
                    from: neighborNode,
                    into: &componentNodes
                )
            }
        }

        // Process each connected component exactly once.
        for node in 0..<nodeCount {
            guard !visitedNodes.contains(node) else {
                continue
            }

            var componentNodes = [Int]()
            collectComponentNodes(from: node, into: &componentNodes)

            let requiredNeighborCount = componentNodes.count - 1

            // In a complete component, every node connects to every other node.
            let isCompleteComponent = componentNodes.allSatisfy { componentNode in
                adjacencyList[componentNode, default: []].count == requiredNeighborCount
            }

            if isCompleteComponent {
                completeComponentCount += 1
            }
        }

        return completeComponentCount
    }
}