class Solution {
    func minReorder(_ n: Int, _ connections: [[Int]]) -> Int {
        var nodes: [[(Int, Bool)]] = [[(Int, Bool)]](repeating: [], count: n)
        var visited: [Bool] = [Bool](repeating: false, count: n)
        var count = 0
    
        func buildGraph() {
            for connection in connections {
                nodes[connection[0]].append((connection[1], true))
                nodes[connection[1]].append((connection[0], false))
            }
        }
    
        func dfs(_ dest: Int) {
            visited[dest] = true
        
            for node in nodes[dest] {
                if visited[node.0] == false {
                    if node.1 { count += 1 }
                    
                    dfs(node.0)
                }
            }
        }
    
        buildGraph()
        dfs(0)
    
        return count
    }
}