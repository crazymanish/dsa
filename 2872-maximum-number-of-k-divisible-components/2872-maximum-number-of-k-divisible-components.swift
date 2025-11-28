/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • O(n)
///     - Building the adjacency list takes O(n) (since edges.count = n - 1 for a tree).
///     - DFS visits each node and edge exactly once.
///     - Overall linear in number of nodes.
///
/// Space Complexity:
///   • O(n)
///     - Adjacency list stores 2 * (n - 1) edges → O(n)
///     - Visited array: O(n)
///     - Recursion stack: O(n) in the worst case (skewed tree)
///
/// Problem Description:
///   We are given a tree with n nodes, each having a value. We want to split the
///   tree into the maximum number of connected components such that the sum of
///   values in each component is divisible by k.
///
/// Approach:
///   - Treat the graph as a rooted tree (root at node 0).
///   - Use DFS to compute the subtree sum for each node.
///   - If a subtree sum is divisible by k, we "cut" this component:
///       • Increase the count of valid components.
///       • Return 0 upwards so that this subtree doesn't contribute to ancestor sums.
///   - Otherwise, return the subtree sum to be added to its parent.
/// ---------------------------------------------------------------------------

class Solution {
    func maxKDivisibleComponents(_ n: Int, _ edges: [[Int]], _ values: [Int], _ k: Int) -> Int {
        // Adjacency list representation of the tree
        var adjacencyList = [[Int]](repeating: [], count: n)
        
        // Track visited nodes during DFS
        var visited = [Bool](repeating: false, count: n)
        
        // Result: number of components whose sum is divisible by k
        var componentCount = 0

        // Build the undirected graph
        for edge in edges {
            let u = edge[0]
            let v = edge[1]
            adjacencyList[u].append(v)
            adjacencyList[v].append(u)
        }

        // Depth-first search returning subtree sum modulo k logic
        func dfs(_ node: Int) -> Int {
            visited[node] = true
            var subtreeSum = values[node]

            // Explore all unvisited neighbors (children in the rooted tree)
            for neighbor in adjacencyList[node] where !visited[neighbor] {
                subtreeSum += dfs(neighbor)
            }

            // If this subtree's sum is divisible by k, it forms a valid component
            if subtreeSum % k == 0 {
                componentCount += 1
                return 0   // Cut here: don't pass this sum up to the parent
            }
            
            // Otherwise, propagate the sum upward
            return subtreeSum
        }

        // Root the DFS at node 0
        _ = dfs(0)

        return componentCount
    }
}
