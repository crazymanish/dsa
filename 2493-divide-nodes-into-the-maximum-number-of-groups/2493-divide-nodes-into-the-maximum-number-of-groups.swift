import Foundation

class Solution {
    func magnificentSets(_ n: Int, _ edges: [[Int]]) -> Int {
        // Initialize adjacency list
        var adjacencyList = [[Int]](repeating: [Int](), count: n + 1)
        for edge in edges {
            adjacencyList[edge[0]].append(edge[1])
            adjacencyList[edge[1]].append(edge[0])
        }

        // Global variable to track visited nodes
        var nodeVisited = [Bool](repeating: false, count: 501)
        
        // Inline partition function
        func partition(_ root: Int) -> Int {
            // If the root is already visited, return 0
            if nodeVisited[root] {
                return 0
            }
            // Mark the root as visited
            nodeVisited[root] = true
            
            // Initialize queue and group arrays
            var queue = [root]
            var group = [Int](repeating: -1, count: adjacencyList.count)
            group[root] = 0
            
            // BFS to partition the graph
            while !queue.isEmpty {
                var nextQueue = [Int]()
                for node in queue {
                    for neighbor in adjacencyList[node] {
                        if group[neighbor] == -1 {
                            group[neighbor] = group[node] + 1
                            nextQueue.append(neighbor)
                        } else if abs(group[node] - group[neighbor]) != 1 {
                            return -1
                        }
                    }
                }
                queue = nextQueue
            }
            
            // Calculate the result
            var maxGroupSize = 0
            for i in 0..<adjacencyList.count {
                if group[i] != -1 {
                    maxGroupSize = max(maxGroupSize, group[i] + 1, partition(i))
                }
            }
            return maxGroupSize
        }
        
        // Calculate the result
        var totalGroups = 0
        for i in 1...n {
            let setGroups = partition(i)
            if setGroups == -1 {
                return -1
            } else {
                totalGroups += setGroups
            }
        }
        return totalGroups
    }
}