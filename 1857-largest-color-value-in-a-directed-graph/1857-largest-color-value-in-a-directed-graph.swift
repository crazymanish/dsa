// Time Complexity: O(V + E), where V is the number of nodes (colors.count) and E is the number of edges.
// This is because building the graph and in-degrees takes O(V + E).
// The topological sort (Kahn's algorithm) processes each node and each edge exactly once.
// Inside the loop, updating color counts for a node's neighbors involves iterating over at most 26 colors,
// which is a constant factor, making the overall processing of nodes and edges O(V + E).

// Space Complexity: O(V + E), where V is the number of nodes and E is the number of edges.
// `adjList` stores the graph, taking O(V + E) space.
// `inDegree` array takes O(V) space.
// `queue` can store up to O(V) nodes.
// `maxColorCounts` stores a dictionary for each node, where each inner dictionary has at most 26 entries (for 26 possible colors).
// Thus, `maxColorCounts` takes O(V * 26) = O(V) space.
// The `nodeColors` array takes O(V) space.
class Solution {
    func largestPathValue(_ colorsString: String, _ edges: [[Int]]) -> Int {
        // adjList: Adjacency list representation of the graph. Maps a node to its list of direct neighbors.
        var adjList = [Int: [Int]]()
        
        // inDegree: Array to store the in-degree (number of incoming edges) for each node.
        var inDegree = Array(repeating: 0, count: colorsString.count)
        
        // Build the adjacency list and calculate in-degrees for all nodes.
        for edge in edges {
            let sourceNode = edge[0]
            let destinationNode = edge[1]
            adjList[sourceNode, default: []].append(destinationNode)
            inDegree[destinationNode] += 1
        }
        
        // queue: Stores nodes that currently have an in-degree of 0. These are starting points for paths.
        var queue: [Int] = [Int]()
        for nodeIndex in 0..<inDegree.count {
            if inDegree[nodeIndex] == 0 {
                queue.append(nodeIndex)
            }
        }
        
        // nodeColors: Convert the input colors string into an array of characters for easy access by index.
        let nodeColors = Array(colorsString)
        
        // maxColorCounts: Dynamic programming table.
        // `maxColorCounts[node]` stores a dictionary where keys are colors and values are the maximum
        // occurrences of that color on any path ending at `node`.
        var maxColorCounts = [Int: [Character: Int]]()
        
        // overallMaxPathValue: Stores the maximum path value found across all paths in the graph.
        var overallMaxPathValue = -1
        
        // processedNodesCount: Tracks the number of nodes processed during the topological sort.
        // Used to detect cycles.
        var processedNodesCount = 0
        
        // Perform a topological sort using Kahn's algorithm (BFS-based).
        while !queue.isEmpty {
            let currentNode = queue.removeLast() // Dequeue a node with 0 in-degree
            processedNodesCount += 1
            
            // currentPathColorCounts: Get the color counts for paths ending at the `currentNode`.
            // Initialize with existing counts or an empty dictionary if this is the first time visiting.
            var currentPathColorCounts = maxColorCounts[currentNode, default: [:]]
            
            // Increment the count for the color of the `currentNode` itself.
            currentPathColorCounts[nodeColors[currentNode], default: 0] += 1
            
            // Update the overall maximum path value with the count of the current node's color.
            overallMaxPathValue = max(overallMaxPathValue, currentPathColorCounts[nodeColors[currentNode], default: 0])
            
            // Iterate over all neighbors of the `currentNode`.
            for neighbor in adjList[currentNode, default: []] {
                // neighborPathColorCounts: Get the current color counts for paths ending at the `neighbor`.
                var neighborPathColorCounts = maxColorCounts[neighbor, default: [:]]
                
                // Merge color counts from `currentNode`'s paths into `neighbor`'s paths.
                // For each color, take the maximum count seen so far on any path ending at `neighbor`
                // by considering paths coming from `currentNode`.
                for (color, count) in currentPathColorCounts {
                    neighborPathColorCounts[color, default: 0] = max(neighborPathColorCounts[color, default: 0], count)
                }
                
                // Store the updated color counts for the `neighbor`.
                maxColorCounts[neighbor] = neighborPathColorCounts
                
                // Decrement the in-degree of the `neighbor`.
                inDegree[neighbor] -= 1
                
                // If the `neighbor`'s in-degree becomes 0, add it to the queue for processing.
                if inDegree[neighbor] == 0 {
                    queue.append(neighbor)
                }
            }
        }
        
        // If `processedNodesCount` is less than the total number of nodes, it means there's a cycle in the graph.
        // In this case, a path can be infinitely long, so return -1.
        // Otherwise, return the `overallMaxPathValue` found.
        return processedNodesCount < colorsString.count ? -1 : overallMaxPathValue
    }
}