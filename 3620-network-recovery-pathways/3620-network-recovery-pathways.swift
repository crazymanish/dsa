class Solution {
    /**
     Problem Summary:
     Find the maximum possible minimum edge score on a valid path from node `0` to node `n - 1`.
     Only online nodes can be used, and the total path cost must be at most `k`.

     Strategy:
     - Build a graph using only edges where both endpoints are online.
     - Topologically sort the online nodes using Kahn's algorithm.
     - Binary search the answer:
       - For a candidate score, only use edges with cost >= score.
       - Check whether the cheapest path from `0` to `n - 1` is within budget `k`.

     Time Complexity:
     O((V + E) * log C), where C is the maximum edge cost.

     Space Complexity:
     O(V + E), for the adjacency list, topological order, queue, and distance array.
     */
    func findMaxPathScore(_ edges: [[Int]], _ online: [Bool], _ k: Int) -> Int {
        let nodeCount = online.count

        var graph = Array(repeating: [(neighbor: Int, cost: Int)](), count: nodeCount)
        var inDegree = Array(repeating: 0, count: nodeCount)
        var maximumEdgeCost = 0

        // Build graph using only edges whose endpoints are both online.
        for edge in edges {
            let source = edge[0]
            let destination = edge[1]
            let cost = edge[2]

            guard online[source], online[destination] else { continue }

            graph[source].append((destination, cost))
            inDegree[destination] += 1
            maximumEdgeCost = max(maximumEdgeCost, cost)
        }

        // Topologically sort all online nodes.
        var topologicalOrder = [Int]()
        var queue = [Int]()

        for node in 0..<nodeCount {
            if online[node] && inDegree[node] == 0 {
                queue.append(node)
            }
        }

        var queueIndex = 0

        while queueIndex < queue.count {
            let currentNode = queue[queueIndex]
            queueIndex += 1

            topologicalOrder.append(currentNode)

            for edge in graph[currentNode] {
                inDegree[edge.neighbor] -= 1

                if inDegree[edge.neighbor] == 0 {
                    queue.append(edge.neighbor)
                }
            }
        }

        var lowScore = 0
        var highScore = maximumEdgeCost
        var bestScore = -1

        // Binary search the largest minimum edge cost that still allows a path within budget.
        while lowScore <= highScore {
            let candidateScore = lowScore + (highScore - lowScore) / 2

            var minimumCost = Array(repeating: Int.max, count: nodeCount)
            minimumCost[0] = 0

            // Relax edges in topological order.
            for currentNode in topologicalOrder {
                guard minimumCost[currentNode] != Int.max else { continue }

                for edge in graph[currentNode] {
                    // Only allow edges that satisfy the candidate minimum score.
                    guard edge.cost >= candidateScore else { continue }

                    let newCost = minimumCost[currentNode] + edge.cost

                    if newCost < minimumCost[edge.neighbor] {
                        minimumCost[edge.neighbor] = newCost
                    }
                }
            }

            if minimumCost[nodeCount - 1] <= k {
                bestScore = candidateScore
                lowScore = candidateScore + 1
            } else {
                highScore = candidateScore - 1
            }
        }

        return bestScore
    }
}