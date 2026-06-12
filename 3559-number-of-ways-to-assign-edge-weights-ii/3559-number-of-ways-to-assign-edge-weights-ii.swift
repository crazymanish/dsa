class Solution {
    /**
     Problem Summary:
     Given a tree and multiple queries `[u, v]`, return the number of valid edge-weight assignments
     on the path from `u` to `v` such that the total path weight is odd.

     Strategy:
     - Build an adjacency list for the tree.
     - DFS from node `1` to compute depth and direct parent for every node.
     - Build a binary lifting table for fast LCA queries.
     - For each query, compute the path length using depths and LCA.
     - If the path has `len` edges, exactly `2^(len - 1)` assignments produce an odd sum.

     Time Complexity:
     - Preprocessing: O(n log n)
     - Each query: O(log n)
     - Total: O((n + q) log n)

     Space Complexity:
     - O(n log n)
     */
    func assignEdgeWeights(_ edges: [[Int]], _ queries: [[Int]]) -> [Int] {
        let nodeCount = edges.count + 1
        var tree = Array(repeating: [Int](), count: nodeCount + 1)

        for edge in edges {
            let firstNode = edge[0]
            let secondNode = edge[1]

            tree[firstNode].append(secondNode)
            tree[secondNode].append(firstNode)
        }

        var depth = Array(repeating: 0, count: nodeCount + 1)
        var parent = Array(repeating: 0, count: nodeCount + 1)

        dfs(currentNode: 1, parentNode: 1, currentDepth: 0, tree: tree, parent: &parent, depth: &depth)

        let ancestors = buildAncestors(parent: parent, nodeCount: nodeCount)

        var result = [Int]()
        result.reserveCapacity(queries.count)

        for query in queries {
            let firstNode = query[0]
            let secondNode = query[1]

            let commonAncestor = lca(firstNode, secondNode, ancestors: ancestors, depth: depth)
            let pathLength = depth[firstNode] + depth[secondNode] - 2 * depth[commonAncestor]

            // A path of length 0 has no edges, so no valid odd-sum assignment exists.
            guard pathLength > 0 else {
                result.append(0)
                continue
            }

            // For `pathLength` edges, half of all assignments have odd total sum.
            result.append(powerMod(2, pathLength - 1))
        }

        return result
    }

    private func dfs(currentNode: Int, parentNode: Int, currentDepth: Int, tree: [[Int]], parent: inout [Int], depth: inout [Int]) {
        parent[currentNode] = parentNode
        depth[currentNode] = currentDepth

        for nextNode in tree[currentNode] where nextNode != parentNode {
            dfs(currentNode: nextNode, parentNode: currentNode, currentDepth: currentDepth + 1, tree: tree, parent: &parent, depth: &depth)
        }
    }

    private func buildAncestors(parent: [Int], nodeCount: Int) -> [[Int]] {
        let maxPower = Int(log2(Double(nodeCount))) + 1
        var ancestors = Array(repeating: Array(repeating: 0, count: nodeCount + 1), count: maxPower)

        // Base level: the 2^0-th ancestor is the direct parent.
        for node in 1...nodeCount {
            ancestors[0][node] = parent[node]
        }

        // Binary lifting transition.
        for power in 1..<maxPower {
            for node in 1...nodeCount {
                let intermediateAncestor = ancestors[power - 1][node]
                ancestors[power][node] = ancestors[power - 1][intermediateAncestor]
            }
        }

        return ancestors
    }

    private func lca(_ firstNode: Int, _ secondNode: Int, ancestors: [[Int]], depth: [Int]) -> Int {
        var deeperNode = firstNode
        var shallowerNode = secondNode

        // Ensure `deeperNode` is at least as deep as `shallowerNode`.
        if depth[deeperNode] < depth[shallowerNode] {
            swap(&deeperNode, &shallowerNode)
        }

        var depthDifference = depth[deeperNode] - depth[shallowerNode]
        var power = 0

        // Lift the deeper node until both nodes are on the same depth.
        while depthDifference > 0 {
            if depthDifference & 1 == 1 {
                deeperNode = ancestors[power][deeperNode]
            }

            depthDifference >>= 1
            power += 1
        }

        if deeperNode == shallowerNode {
            return deeperNode
        }

        // Lift both nodes while their 2^power ancestors are different.
        for power in stride(from: ancestors.count - 1, through: 0, by: -1) {
            if ancestors[power][deeperNode] != ancestors[power][shallowerNode] {
                deeperNode = ancestors[power][deeperNode]
                shallowerNode = ancestors[power][shallowerNode]
            }
        }

        return ancestors[0][deeperNode]
    }

    private func powerMod(_ base: Int, _ exponent: Int) -> Int {
        let mod = 1_000_000_007
        var result = 1
        var currentBase = base % mod
        var remainingExponent = exponent

        // Binary exponentiation under modulo.
        while remainingExponent > 0 {
            if remainingExponent & 1 == 1 {
                result = result * currentBase % mod
            }

            currentBase = currentBase * currentBase % mod
            remainingExponent >>= 1
        }

        return result
    }
}