class Solution {
    func mostProfitablePath(_ edges: [[Int]], _ bob: Int, _ amount: [Int]) -> Int {
        let nodeCount = amount.count
        var maxIncome = Int.min
        var tree: [[Int]] = Array(repeating: [], count: nodeCount) // Adjacency list to represent the tree
        var bobPath = [Int: Int]() // Store Bob's path (node -> time taken to reach)
        var visited = Array(repeating: false, count: nodeCount) // Keep track of visited nodes
        var queue: [(node: Int, time: Int, income: Int)] = [(0, 0, 0)] // Queue for BFS

        // Build the tree from the given edges
        for edge in edges {
            tree[edge[0]].append(edge[1])
            tree[edge[1]].append(edge[0])
        }

        // Nested function to find Bob's path using DFS
        func findBobPath(_ currentNode: Int, _ time: Int) -> Bool {
            bobPath[currentNode] = time // Record the time taken to reach this node
            visited[currentNode] = true // Mark the node as visited

            if currentNode == 0 { return true } // Base case: Bob reached the root

            // Explore adjacent nodes recursively
            for adjacentNode in tree[currentNode] {
                if !visited[adjacentNode], findBobPath(adjacentNode, time + 1) {
                    return true // Found a path to the root
                }
            }

            // If no path to the root is found from this node, remove it from bobPath
            bobPath.removeValue(forKey: currentNode)
            return false
        }

        // Find Bob's path from his starting node to the root (node 0)
        findBobPath(bob, 0)

        // BFS traversal to find Alice's most profitable path
        visited = Array(repeating: false, count: nodeCount) // Reset visited array for BFS
        while !queue.isEmpty {
            let (currentNode, time, currentIncome) = queue.removeFirst() // Dequeue a node

            // Calculate income based on who reaches the node first
            var newIncome = currentIncome
            if bobPath[currentNode] == nil || time < bobPath[currentNode]! {
                newIncome += amount[currentNode] // Alice reaches first
            } else if time == bobPath[currentNode]! {
                newIncome += amount[currentNode] / 2 // Both reach simultaneously
            }

            // If it's a leaf node (except the root), update maxIncome
            if tree[currentNode].count == 1 && currentNode != 0 {
                maxIncome = max(maxIncome, newIncome)
            }

            // Explore adjacent nodes
            for adjacentNode in tree[currentNode] {
                if !visited[adjacentNode] {
                    queue.append((adjacentNode, time + 1, newIncome)) // Enqueue adjacent node
                }
            }

            visited[currentNode] = true // Mark the current node as visited
        }

        return maxIncome // Return the maximum income Alice can achieve
    }
}