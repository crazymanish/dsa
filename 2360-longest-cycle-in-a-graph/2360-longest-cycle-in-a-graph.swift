class Solution {
    func longestCycle(_ edges: [Int]) -> Int {
        var visited: [Bool] = [Bool](repeating: false, count: edges.count)
        
        func dfs(_ node: Int, currentNode: Int) -> (Int, Bool) {
            visited[node] = true
            
            let neighbourNode = edges[node]
            
            if neighbourNode == -1 { return (-1, false) }
            
            if visited[neighbourNode] == false {
                let (cycleCount, isCycle) = dfs(neighbourNode, currentNode: currentNode)
                
                if isCycle {
                    return (cycleCount+1, isCycle)
                } else {
                    visited[node] = false
                    return (-1, isCycle)
                }
            }
            
            if neighbourNode == currentNode { return (1, true) }
            
            visited[node] = false
            return (-1, false)
        }
        
        var maxCycleCount = -1
        for node in 0..<edges.count {
            if visited[node] == false {
                let (cycleCount, _) = dfs(node, currentNode: node)
                maxCycleCount = max(maxCycleCount, cycleCount)
                visited[node] = true
            }
        }
        
        return maxCycleCount
    }
}