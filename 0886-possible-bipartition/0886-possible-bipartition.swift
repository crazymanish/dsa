class Solution {
    func possibleBipartition(_ N: Int, _ dislikes: [[Int]]) -> Bool {
        var graph:[[Int]] = Array(repeating: [], count: N)
        var visited = Array(repeating: 0, count: graph.count)
        
        for dislike in dislikes {
            let from = dislike[0]-1
            let to = dislike[1]-1
            
            graph[from].append(to)
            graph[to].append(from)
        }
    
        func dfs(_ node:Int, _ parent:Int? = nil) -> Bool {
            if parent == nil {
                visited[node] = 1
            }
            
            for child in graph[node] {
                if visited[child] == 0 {
                    visited[child] = visited[node] == 1 ? 2 : 1
                    if dfs(child, node) == false { return false }
                } else {
                    if visited[child] == visited[node] { return false }
                }
            }
            
            return true
        }
        
        for index in 0..<N {
            if visited[index] == 0 {
                let result = dfs(index)
                // let result = bfs(i ,graph, &visited)
                if result == false { return false }
            }
        }
        
        return true
    }
}

/*
        func bfs(_ node:Int, _ graph:[[Int]], _ visited:inout[Int])->Bool{
            var queue:[Int] = []
            queue.append(node)
            visited[node] = 1

            while !queue.isEmpty{
                let item = queue.removeFirst()
                for child in graph[item]{
                    if visited[child] == 0{
                        visited[child] = visited[item] == 1 ? 2 : 1
                        queue.append(child)
                    }else{
                        if visited[child] == visited[item] { return false }
                    }
                }
            }
            
            return true
        }
*/