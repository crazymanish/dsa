class Solution {
    func buildMatrix(_ k: Int, _ rowConditions: [[Int]], _ colConditions: [[Int]]) -> [[Int]] {
        var matrix = Array(repeating: Array(repeating: 0, count: k), count: k)
        guard let sortedRows = Graph(nodes: Array(1...k), edges: rowConditions).sort(),
              let sortedCols = Graph(nodes: Array(1...k), edges: colConditions).sort()
        else { return [] }

        for num in 1...k {
            if let row = sortedRows.firstIndex(of: num), let col = sortedCols.firstIndex(of: num) {
                matrix[row][col] = num
            }
        }

        return matrix
    }
}

class Graph {
    private let nodes: [Int]
    private var adj = [Int: [Int]]()

    init(nodes: [Int], edges: [[Int]]) {
        self.nodes = nodes
        for edge in edges {
            adj[edge[0], default: []].append(edge[1])
        }
    }

    func sort() -> [Int]? {
        enum NodeState { case visited, visiting, unvisited }
        var nodeState = [Int: NodeState]()
        var stack: [Int] = []

        for node in nodes { nodeState[node] = .unvisited }
        for node in nodes {
            if !dfs(node) {
                return nil
            }
        }
        
        return stack.reversed()
    
        func dfs(_ node: Int) -> Bool {
            if let state = nodeState[node], state == .visited { return true }
            if let state = nodeState[node], state == .visiting { return false }
            nodeState[node] = .visiting
        
            if let neighbors = adj[node] {
                for neighbor in neighbors {
                    if !dfs(neighbor) { return false }
                }
            }
        
            nodeState[node] = .visited
            stack.append(node)
            return true
        }      
    }
}