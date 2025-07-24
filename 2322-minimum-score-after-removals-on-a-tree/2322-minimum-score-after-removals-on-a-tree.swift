/*
Time Complexity: O(N^2)
- The primary bottleneck is the nested loop that iterates through all unique pairs of edges. For a tree with N nodes, there are N-1 edges, leading to roughly (N-1) * (N-2) / 2 pairs, which is O(N^2).
- The initial DFS pre-computation runs in O(N) time.

Space Complexity: O(N)
- The adjacency list, subtree XOR sums array, and DFS start/end time arrays each require space proportional to the number of nodes N.
*/
class Solution {
    /// Calculates the minimum possible score after removing two edges from a tree.
    /// The score is defined as the difference between the largest and smallest XOR sums
    /// of the three resulting tree components.
    ///
    /// - Parameters:
    ///   - nums: An array of integer values for each node.
    ///   - edges: An array of pairs representing the edges of the tree.
    /// - Returns: The minimum possible score.
    func minimumScore(_ nums: [Int], _ edges: [[Int]]) -> Int {
        let nodeCount = nums.count
        var minScore = Int.max

        // MARK: - 1. Build Adjacency List
        var adjacencyList = [[Int]](repeating: [], count: nodeCount)
        for edge in edges {
            adjacencyList[edge[0]].append(edge[1])
            adjacencyList[edge[1]].append(edge[0])
        }

        // MARK: - 2. DFS Pre-computation
        // We perform a single DFS traversal to calculate two key properties for each node:
        //  - The XOR sum of its entire subtree.
        //  - Its start and end times in the DFS traversal for fast ancestry checks.
        var subtreeXORs = [Int](repeating: 0, count: nodeCount)
        var startTimes = [Int](repeating: 0, count: nodeCount)
        var endTimes = [Int](repeating: 0, count: nodeCount)
        var timer = 0

        /// Performs a DFS traversal to pre-compute `subtreeXORs`, `startTimes`, and `endTimes`.
        func dfs(node: Int, parent: Int) {
            // Mark the "entry" time for the current node.
            timer += 1
            startTimes[node] = timer
            subtreeXORs[node] = nums[node]
            
            for neighbor in adjacencyList[node] where neighbor != parent {
                dfs(node: neighbor, parent: node)
                // In post-order, combine the child's XOR sum with the current node's.
                subtreeXORs[node] ^= subtreeXORs[neighbor]
            }
            
            // Mark the "exit" time after all children have been fully explored.
            endTimes[node] = timer
        }
        
        /// Checks if node `u` is an ancestor of node `v` in O(1) time.
        /// A node `u` is an ancestor of `v` if its DFS traversal interval [startTime, endTime]
        /// completely contains `v`'s interval.
        func isAncestor(_ u: Int, of v: Int) -> Bool {
            return startTimes[u] <= startTimes[v] && endTimes[u] >= endTimes[v]
        }
        
        // Start the pre-computation from node 0 as the arbitrary root.
        dfs(node: 0, parent: -1)
        let totalXOR = subtreeXORs[0]

        // MARK: - 3. Iterate Through All Edge Pairs
        // Check every possible pair of edges to remove.
        for i in 0..<(nodeCount - 1) {
            for j in (i + 1)..<(nodeCount - 1) {
                // To reason about subtrees, we need to know which node is the parent.
                // The child `v` is the node visited later in the DFS (larger start time).
                let u1 = startTimes[edges[i][0]] < startTimes[edges[i][1]] ? edges[i][0] : edges[i][1]
                let v1 = u1 == edges[i][0] ? edges[i][1] : edges[i][0]
                
                let u2 = startTimes[edges[j][0]] < startTimes[edges[j][1]] ? edges[j][0] : edges[j][1]
                let v2 = u2 == edges[j][0] ? edges[j][1] : edges[j][0]

                var part1, part2, part3: Int

                // Calculate the three component XOR sums based on the edges' relationship.
                if isAncestor(v1, of: u2) {
                    // Case 1: Edge 2 is in the subtree of edge 1 (nested).
                    // The components are: subtree(v2), subtree(v1) \ subtree(v2), and the rest.
                    part1 = subtreeXORs[v2]
                    part2 = subtreeXORs[v1] ^ subtreeXORs[v2]
                    part3 = totalXOR ^ subtreeXORs[v1]
                } else if isAncestor(v2, of: u1) {
                    // Case 2: Edge 1 is in the subtree of edge 2 (nested).
                    // The components are: subtree(v1), subtree(v2) \ subtree(v1), and the rest.
                    part1 = subtreeXORs[v1]
                    part2 = subtreeXORs[v2] ^ subtreeXORs[v1]
                    part3 = totalXOR ^ subtreeXORs[v2]
                } else {
                    // Case 3: The subtrees are disjoint.
                    // The components are: subtree(v1), subtree(v2), and the rest.
                    part1 = subtreeXORs[v1]
                    part2 = subtreeXORs[v2]
                    part3 = totalXOR ^ subtreeXORs[v1] ^ subtreeXORs[v2]
                }
                
                // Calculate the score for this partition and update the minimum.
                let maxPart = max(part1, part2, part3)
                let minPart = min(part1, part2, part3)
                minScore = min(minScore, maxPart - minPart)
            }
        }
        
        return minScore
    }
}