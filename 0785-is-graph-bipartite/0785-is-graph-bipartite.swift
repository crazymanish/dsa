class Solution {
    /*
        1. Question is similar to Q.886. Possible Bipartition
        2. The graph is already give so use it when checking neighbors
        3. Create a colors map which will be used to store the color of a node either 0||1
    
    */
    func isBipartite(_ graph: [[Int]]) -> Bool {
        var colors: [Int: Int] = [:]
        
        func dfs(_ node: Int, _ color: Int) -> Bool {
            if let hasColor = colors[node] {
                return hasColor == color
            }
        
            colors[node] = color
        
            for neighbor in graph[node] {
                if dfs(neighbor, color^1) == false {
                    return false
                }
            }
            
            return true
        }
        
        for node in 0..<graph.count {
            if colors[node] == nil && dfs(node, 0) == false {
                return false
            }
        }
        
        return true
    }
}