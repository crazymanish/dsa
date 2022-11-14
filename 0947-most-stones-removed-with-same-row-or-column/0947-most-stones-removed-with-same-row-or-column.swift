class Solution {
    func removeStones(_ stones: [[Int]]) -> Int {
        if stones.count == 1 { return 0 }
        
        var graph: [Int: [Int]] = [:]
        var removed: Int = 0 
        var visited: [Int] = Array(repeating: 0, count: stones.count)
        
        //Building Graph
        for i in 0 ..< stones.count {
            for j in (i + 1) ..< stones.count {
                if stones[j][0] == stones[i][0] ||  stones[j][1] == stones[i][1] {
                    graph[i,default:[]].append(j)
                    graph[j,default:[]].append(i)
                }
            }
        }
        
        for stoneIndex in 0 ..< stones.count {
            if visited[stoneIndex] == 0 {
                dfs(stoneIndex)
                removed += 1
            }
        }
        
        func dfs(_ src: Int) {
            visited[src] = 1
            for neighbour in graph[src] ?? [] {
                if visited[neighbour] == 0 {
                    dfs(neighbour)
                }
            }
        }
        
        return stones.count -  removed
    }
}