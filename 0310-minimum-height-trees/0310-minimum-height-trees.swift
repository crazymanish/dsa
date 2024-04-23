class Solution {
    func findMinHeightTrees(_ n: Int, _ edges: [[Int]]) -> [Int] {
        if n == 1 { return [0] }
        if n == 2 { return [0, 1] }

        var graph = Array(repeating: [Int](), count: n)
        var indegrees = Array(repeating: 0, count: n)
        var queue = [Int]()
        var nodesLeft = n

        for edge in edges {
            indegrees[edge[0]] += 1
            indegrees[edge[1]] += 1

            graph[edge[0]].append(edge[1])
            graph[edge[1]].append(edge[0])
        }


        for (node, indegree) in indegrees.enumerated() {
            if indegree == 1 {
                queue.append(node)
            }
        }

        while nodesLeft > 2 {
            let totalLeaves = queue.count
            nodesLeft -= totalLeaves
            for _ in 0..<totalLeaves {
                let node = queue.removeFirst()
                indegrees[node] -= 1
                
                for neighbor in graph[node] {
                    indegrees[neighbor] -= 1

                    if indegrees[neighbor] == 1 {
                        queue.append(neighbor)
                    }
                }
            }
        }

        return queue
    }
}