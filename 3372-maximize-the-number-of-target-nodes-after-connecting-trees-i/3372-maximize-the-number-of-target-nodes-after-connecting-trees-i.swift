// Time Complexity: O(numNodesTree1^2 + numNodesTree2^2)
//   - Building adjacency list for tree2: O(numNodesTree2)
//   - Calculating maxNodesInTree2WithinK_minus_1: numNodesTree2 iterations * O(numNodesTree2) for DFS = O(numNodesTree2^2)
//   - Building adjacency list for tree1: O(numNodesTree1)
//   - Calculating final result: numNodesTree1 iterations * O(numNodesTree1) for DFS = O(numNodesTree1^2)
// Space Complexity: O(numNodesTree1 + numNodesTree2 + maxDistanceK)
//   - Adjacency lists: O(numNodesTree1 + numNodesTree2)
//   - Visited sets in DFS: O(numNodesTree1) or O(numNodesTree2)
//   - Result array: O(numNodesTree1)
//   - DFS recursion stack: O(maxDistanceK) in the worst case
class Solution {
    func maxTargetNodes(_ tree1Edges: [[Int]], _ tree2Edges: [[Int]], _ k_maxDistance: Int) -> [Int] {
        // Number of nodes in tree1. Nodes are 0-indexed, so count is edges.count + 1.
        let numNodesTree1 = tree1Edges.count + 1
        // Number of nodes in tree2.
        let numNodesTree2 = tree2Edges.count + 1

        // If k_maxDistance is 0, each node in tree1 can only reach itself (1 node).
        // The problem implies we add max nodes from tree2 even if k_maxDistance is 0 for tree1 part.
        // However, the original code's dfs returns 1 if maxDist is 0.
        // If k_maxDistance for tree1 traversal is 0, dfs(node, 0) returns 1.
        // Then k_maxDistance-1 for tree2 would be -1. The dfs in original code doesn't handle negative maxDist well,
        // but since k_maxDistance-1 is used, if k_maxDistance = 0, maxDist for tree2 would be -1.
        // Let's assume k_maxDistance >= 0. If k_maxDistance = 0, then for tree2, maxDist is -1.
        // The original dfs returns 1 if maxDist == 0. If maxDist is negative, it will still proceed to sum 1.
        // This implies if k_maxDistance = 0, the number of nodes from tree2 to add would be 1 (a single entry point).
        // So, result[i] = 1 (self in tree1) + 1 (single node from tree2 if k_maxDistance-1 < 0 for tree2's dfs)
        // The problem description is a bit ambiguous here, but let's follow the original code's logic:
        // if k_maxDistance == 0, then maxTree2Count needs to be calculated with k_maxDistance-1 = -1.
        // dfs(node, -1) would return 1 (as maxDist != 0).
        // So, if k_maxDistance == 0, res[i] = dfs(node, 0) + maxNodesInTree2WithinK_minus_1
        // res[i] = 1 + (value from dfs on tree2 with dist -1) = 1 + 1 = 2.
        // The provided `if k == 0 { return Array(repeating: 1, count: n) }` suggests a different interpretation
        // for k_maxDistance = 0 specifically for the overall problem, not just the DFS parameter.
        // This means if k_maxDistance is 0, we only consider nodes in tree1, and each can only reach itself.
        if k_maxDistance == 0 {
            return Array(repeating: 1, count: numNodesTree1)
        }

        // Adjacency list for tree2
        var adjacencyListTree2 = Array(repeating: [Int](), count: numNodesTree2)
        for edge in tree2Edges {
            adjacencyListTree2[edge[0]].append(edge[1])
            adjacencyListTree2[edge[1]].append(edge[0])
        }

        // Calculate the maximum number of nodes reachable in tree2 within (k_maxDistance - 1) steps
        // from any single entry node in tree2.
        var maxNodesInTree2WithinK_minus_1 = 0 // Changed from Int.min as count cannot be negative.
                                                // If k_maxDistance-1 < 0, dfs returns 1.
        if k_maxDistance - 1 < 0 { // If k_maxDistance is 0 (already handled) or 1.
                                 // If k_maxDistance is 1, then k_maxDistance - 1 is 0. dfs returns 1.
            maxNodesInTree2WithinK_minus_1 = 1
        } else if numNodesTree2 > 0 { // Ensure tree2 is not empty
            for startNodeIndexTree2 in 0..<numNodesTree2 {
                var visitedNodesTree2 = Set<Int>()
                // Pass adjacencyListTree2 to the DFS helper
                let currentReachableNodesTree2 = dfs(
                    node: startNodeIndexTree2,
                    remainingDistance: k_maxDistance - 1,
                    visited: &visitedNodesTree2,
                    adjacencyList: adjacencyListTree2 // Pass the correct adjacency list
                )
                if currentReachableNodesTree2 > maxNodesInTree2WithinK_minus_1 {
                    maxNodesInTree2WithinK_minus_1 = currentReachableNodesTree2
                }
            }
        } else { // tree2 is empty
            maxNodesInTree2WithinK_minus_1 = 0
        }


        // Adjacency list for tree1
        var adjacencyListTree1 = Array(repeating: [Int](), count: numNodesTree1)
        for edge in tree1Edges {
            adjacencyListTree1[edge[0]].append(edge[1])
            adjacencyListTree1[edge[1]].append(edge[0])
        }

        // Compute the answer for each node in tree1.
        // The result for a node in tree1 is the sum of:
        // 1. Nodes reachable in tree1 within k_maxDistance steps.
        // 2. maxNodesInTree2WithinK_minus_1 (calculated above).
        var resultTargetNodes = Array(repeating: 0, count: numNodesTree1)
        for startNodeIndexTree1 in 0..<numNodesTree1 {
            var visitedNodesTree1 = Set<Int>()
            // Nodes reachable in tree1 from startNodeIndexTree1
            let reachableInTree1 = dfs(
                node: startNodeIndexTree1,
                remainingDistance: k_maxDistance,
                visited: &visitedNodesTree1,
                adjacencyList: adjacencyListTree1 // Pass the correct adjacency list
            )
            resultTargetNodes[startNodeIndexTree1] = reachableInTree1 + maxNodesInTree2WithinK_minus_1
        }
        return resultTargetNodes

        // Helper DFS function to count unvisited nodes in a tree within a given distance.
        // This function is now generic and accepts an adjacency list.
        func dfs(node: Int, remainingDistance: Int, visited: inout Set<Int>, adjacencyList: [[Int]]) -> Int {
            // If remainingDistance is negative, it means we've exceeded the allowed steps.
            // However, the problem seems to imply that a node can always reach itself.
            // The original code's base case `if maxDist == 0 { return 1 }` handles the exact distance.
            // If remainingDistance < 0, the loop for neighbors won't add more, and it'll return the initial `count = 1`.
            if remainingDistance < 0 { return 0 } // No nodes can be reached if distance is negative.
                                                  // The problem implies we count the current node if distance allows.
                                                  // If remainingDistance is exactly 0, current node is counted.
            
            // Mark current node as visited (important to do it here for this specific DFS logic where `insert` checks)
            // The original `visited.insert(neighbor).inserted` handles this, so we add current node *before* exploring.
            visited.insert(node) // Ensure the starting node of this DFS call is marked.

            if remainingDistance == 0 {
                return 1 // Only the current node itself is reachable.
            }

            var count = 1 // Start with the current node.
            for neighbor in adjacencyList[node] {
                // If neighbor was already visited in the *current DFS path* from the initial start node, skip.
                // The `visited` set is passed by reference and accumulates across recursive calls for a single top-level DFS.
                if !visited.contains(neighbor) { // Check before inserting to avoid re-processing
                    visited.insert(neighbor) // Mark as visited
                    count += dfs(node: neighbor, remainingDistance: remainingDistance - 1, visited: &visited, adjacencyList: adjacencyList)
                }
            }
            return count
        }
    }
}