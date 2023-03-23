class Solution {
    func makeConnected(_ n: Int, _ connections: [[Int]]) -> Int {
        if connections.count < n-1 { return -1 }
        
        var connectedNodes = Array(repeating:Set<Int>(), count:n)
        for connection in connections{
            connectedNodes[connection[0]].insert(connection[1])
            connectedNodes[connection[1]].insert(connection[0])
        }
        
        func dfs(_ node: Int) {
            if visited.contains(node) { return }
            visited.insert(node)
        
            let toVisitNodes = connectedNodes[node]
            for toVisitNode in toVisitNodes {
                dfs(toVisitNode)
            }
        }
        
        var visited: Set<Int> = []
        var noOfUnConnnectedNetworks = 0 
        for index in 0..<n {
            if visited.contains(index) == false {
                dfs(index)
                noOfUnConnnectedNetworks += 1
            }
        }
        
        return noOfUnConnnectedNetworks - 1
    }
}