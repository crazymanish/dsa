class Solution {
    func minimumCost(_ nodeCount: Int, _ edgeList: [[Int]], _ queries: [[Int]]) -> [Int] {
        var adjacencyList = [[(Int, Int)]](repeating: [], count: nodeCount) // Adjacency list: node index -> [(neighbor, weight)]
        var componentCost = [Int: Int]() // Cost of each connected component: component ID -> cost
        var nodeComponent = [Int](repeating: -1, count: nodeCount) // Component ID of each node: node index -> component ID
        var isNodeVisited = [Bool](repeating: false, count: nodeCount) // Track visited nodes during DFS
        var componentId = 0 // Counter for connected component IDs

        // Build adjacency list from edge list
        for edge in edgeList {
            let sourceNode = edge[0]
            let destinationNode = edge[1]
            let edgeWeight = edge[2]
            adjacencyList[sourceNode].append((destinationNode, edgeWeight))
            adjacencyList[destinationNode].append((sourceNode, edgeWeight))
        }

        // Depth-First Search to find connected components and their costs
        func depthFirstSearch(_ currentNode: Int, _ currentComponentId: Int) {
            if isNodeVisited[currentNode] { return } // If node is already visited, return
            isNodeVisited[currentNode] = true // Mark node as visited
            nodeComponent[currentNode] = currentComponentId // Assign node to the current component

            for (neighborNode, edgeWeight) in adjacencyList[currentNode] {
                depthFirstSearch(neighborNode, currentComponentId) // Recursively explore neighbors
                componentCost[currentComponentId] = componentCost[currentComponentId] == nil ? edgeWeight : (componentCost[currentComponentId]! & edgeWeight) // Update component cost
            }
        }

        // Find connected components
        for nodeIndex in 0..<nodeCount {
            if !isNodeVisited[nodeIndex] {
                depthFirstSearch(nodeIndex, componentId) // Start DFS from unvisited nodes
                componentId += 1 // Increment component ID for the next component
            }
        }

        // Process queries
        return queries.map { query in
            let startNode = query[0]
            let targetNode = query[1]
            // If nodes are in the same component, return the component cost, otherwise -1
            return nodeComponent[startNode] == nodeComponent[targetNode] ? (componentCost[nodeComponent[startNode]] ?? -1) : -1
        }
    }
}