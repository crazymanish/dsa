class Solution {
    /**
     Problem Summary:
     Given an undirected tree, find the maximum depth from node `1`.
     The number of valid edge-weight assignments along a deepest path is `2^(depth - 1)` modulo `1_000_000_007`.

     Strategy:
     - Build an adjacency list for the tree.
     - Run BFS from node `1` to find the maximum depth.
     - Use fast modular exponentiation to compute `2^(maxDepth - 1)`.

     Time Complexity:
     O(n), where `n` is the number of nodes.

     Space Complexity:
     O(n), for the adjacency list, BFS queue, and visited array.
     */
    func assignEdgeWeights(_ edges: [[Int]]) -> Int {
        let modulo = 1_000_000_007
        let nodeCount = edges.count + 1

        var graph = Array(repeating: [Int](), count: nodeCount + 1)

        // Build the undirected adjacency list.
        for edge in edges {
            let firstNode = edge[0]
            let secondNode = edge[1]

            graph[firstNode].append(secondNode)
            graph[secondNode].append(firstNode)
        }

        let maximumDepth = findMaximumDepth(from: 1, in: graph)

        return modPow(2, maximumDepth - 1, modulo)
    }

    private func findMaximumDepth(from root: Int, in graph: [[Int]]) -> Int {
        var queue: [(node: Int, depth: Int)] = [(root, 0)]
        var head = 0
        var visited = Array(repeating: false, count: graph.count)
        var maximumDepth = 0

        visited[root] = true

        // Standard BFS to measure the farthest depth from the root.
        while head < queue.count {
            let (currentNode, currentDepth) = queue[head]
            head += 1

            maximumDepth = max(maximumDepth, currentDepth)

            for neighbor in graph[currentNode] {
                guard !visited[neighbor] else { continue }

                visited[neighbor] = true
                queue.append((neighbor, currentDepth + 1))
            }
        }

        return maximumDepth
    }

    private func modPow(_ base: Int, _ exponent: Int, _ modulo: Int) -> Int {
        var result = 1
        var currentBase = base % modulo
        var remainingExponent = exponent

        // Fast exponentiation by squaring.
        while remainingExponent > 0 {
            if remainingExponent & 1 == 1 {
                result = Int((Int64(result) * Int64(currentBase)) % Int64(modulo))
            }

            currentBase = Int((Int64(currentBase) * Int64(currentBase)) % Int64(modulo))
            remainingExponent >>= 1
        }

        return result
    }
}