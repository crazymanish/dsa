class Solution {
    func maxKDivisibleComponents(_ n: Int, _ edges: [[Int]], _ values: [Int], _ k: Int) -> Int {
        var adjList = [[Int]](repeating: [Int](), count: n)
        var subtreeSum = [Int](repeating: 0, count: n)
        var visited = [Bool](repeating: false, count: n)
        var result = 0

        for edge in edges {
            let u = edge[0]
            let v = edge[1]
            adjList[u].append(v)
            adjList[v].append(u)
        }

        func dfs(_ node: Int) -> Int {
            visited[node] = true
            var sum = values[node]

            for neighbor in adjList[node] where !visited[neighbor] {
                sum += dfs(neighbor)
            }

            if sum % k == 0 {
                result += 1
                return 0
            }
            
            return sum
        }
        _ = dfs(0)

        return result
    }
}