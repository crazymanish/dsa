class Solution {
    func countCompleteComponents(_ nodeCount: Int, _ edgeList: [[Int]]) -> Int {
        var adjacencyList = [Int: Set<Int>]() // Adjacency list: node -> set of neighbors
        for edge in edgeList {
            adjacencyList[edge[0], default: []].insert(edge[1]) // Add neighbor to source node's set
            adjacencyList[edge[1], default: []].insert(edge[0]) // Add neighbor to destination node's set (undirected)
        }

        var visitedNodes = Set<Int>() // Set to track visited nodes
        var completeComponentCount = 0 // Count of complete components

        // Depth-First Search to get the size of a connected component
        func getComponentSize(_ startNode: Int) -> Int {
            guard let neighbors = adjacencyList[startNode] else { return 0 } // If no neighbors, component size is 0
            var componentSize = 0 // Initialize component size

            for neighborNode in neighbors where !visitedNodes.contains(neighborNode) {
                visitedNodes.insert(neighborNode) // Mark neighbor as visited
                componentSize += 1 + getComponentSize(neighborNode) // Add neighbor and its subtree size
            }
            return componentSize
        }

        // Iterate through all nodes to find connected components
        for nodeIndex in 0..<nodeCount where !visitedNodes.contains(nodeIndex) {
            let neighbors = adjacencyList[nodeIndex, default: []] // Get neighbors of the current node
            let componentSize = getComponentSize(nodeIndex) // Get the size of the component

            // Check if the component is complete
            guard neighbors.isEmpty || ([nodeIndex] + neighbors).allSatisfy({ adjacencyList[$0, default: []].count == componentSize - 1 }) else { continue }

            completeComponentCount += 1 // Increment count if component is complete
        }

        return completeComponentCount // Return the count of complete components
    }
}