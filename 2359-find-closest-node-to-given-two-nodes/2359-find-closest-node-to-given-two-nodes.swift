// Time Complexity: O(N), where N is the number of nodes (edges.count).
//   - Graph construction takes O(N).
//   - Each call to calculateDistancesBFS traverses each node and edge reachable from the start node at most once.
//     Since each node has at most one outgoing edge, the number of edges is at most N.
//     The queue operations (insert at 0, removeLast) effectively behave as O(1) on average for this specific graph
//     structure because the queue size remains very small (at most 1 element during the path traversal). Thus, BFS is O(N).
//   - Two BFS calls: 2 * O(N) = O(N).
//   - The final loop iterates N times: O(N).
//   - Overall: O(N) + O(N) + O(N) = O(N).
// Space Complexity: O(N).
//   - adjacencyList: Stores at most N nodes and N edges, so O(N).
//   - calculateDistancesBFS:
//     - nodesToVisit (queue): O(N) in the worst case (though for this specific graph, it's O(1) during active traversal of a path).
//     - distanceFromStart (distances array): O(N).
//     - visitedNodes (set): O(N) in the worst case.
//   - distancesFromNode1, distancesFromNode2 arrays: 2 * O(N) = O(N).
//   - Overall: O(N).

class Solution {
    func closestMeetingNode(_ edges: [Int], _ firstNode: Int, _ secondNode: Int) -> Int {
        // Build the adjacency list representation of the graph.
        // Each node has at most one outgoing edge.
        var adjacencyList = [Int: [Int]]()
        for (sourceNode, destinationNode) in edges.enumerated() {
            if destinationNode == -1 { continue } // Skip if there's no outgoing edge.
            adjacencyList[sourceNode, default: []].append(destinationNode)
        }

        // Helper function to perform BFS and calculate distances from a start node.
        func calculateDistancesBFS(_ startNode: Int) -> [Int] {
            // Queue for BFS: stores tuples of (node, distance_from_startNode).
            // Initialized with the startNode and distance 0.
            // Note: `insert(at:0)` and `removeLast()` makes this a FIFO queue.
            var nodesToVisit = [(node: startNode, distance: 0)]
            
            // Stores the shortest distance from startNode to every other node.
            // Initialized with Int.max, representing infinity (unreachable).
            var distanceFromStart = Array(repeating: Int.max, count: edges.count)
            
            // Keeps track of visited nodes to avoid cycles and redundant processing.
            var visitedNodes = Set<Int>()
            visitedNodes.insert(startNode) // Mark the start node as visited.
            
            while !nodesToVisit.isEmpty {
                // Dequeue the element to process.
                let currentElement = nodesToVisit.removeLast()
                let currentNode = currentElement.node
                let currentDistance = currentElement.distance
                
                // Explore neighbors of the current node.
                // For this problem, each node has at most one neighbor via `edges`.
                for neighbor in adjacencyList[currentNode] ?? [] {
                    if !visitedNodes.contains(neighbor) { // If neighbor hasn't been visited yet.
                        visitedNodes.insert(neighbor)
                        // Enqueue the neighbor with updated distance.
                        nodesToVisit.insert((node: neighbor, distance: currentDistance + 1), at: 0)
                        // Record the distance to this neighbor.
                        distanceFromStart[neighbor] = currentDistance + 1
                    }
                }
            }
            return distanceFromStart
        }

        // Calculate distances from firstNode to all other nodes.
        var distancesFromFirstNode = calculateDistancesBFS(firstNode)
        // Calculate distances from secondNode to all other nodes.
        var distancesFromSecondNode = calculateDistancesBFS(secondNode)

        // The distance from a node to itself is 0.
        // This is crucial because the BFS calculates distances to *other* nodes.
        distancesFromFirstNode[firstNode] = 0
        distancesFromSecondNode[secondNode] = 0

        var minMaxDistance = Int.max
        var resultNodeIndex = -1 // Default to -1 if no such meeting node is found.

        // Iterate through all nodes to find the meeting node.
        for i in 0..<edges.count {
            // The distance to a meeting node is the maximum of the distances from firstNode and secondNode.
            let currentMaxDistanceToNode = max(distancesFromFirstNode[i], distancesFromSecondNode[i])
            
            // If this node offers a smaller maximum distance, update our best find.
            if currentMaxDistanceToNode < minMaxDistance {
                minMaxDistance = currentMaxDistanceToNode
                resultNodeIndex = i
            }
        }
        
        return resultNodeIndex
    }
}