class Solution {
    func countPairs(_ n: Int, _ edges: [[Int]]) -> Int {
        var graph: [[Int]] = [[Int]](repeating: [], count: n)
        var visited: [Bool] = [Bool](repeating: false, count: n)
        var countArray: [Int] = []
        var total = 0
    
        func buildGraph() {
            for edge in edges {
                graph[edge[0]].append(edge[1])
                graph[edge[1]].append(edge[0])
            }
        }
    
        func dfs(_ node: Int) -> Int {
            visited[node] = true
            var count = 1
        
            for neighbourNode in graph[node] {
                if visited[neighbourNode] == false {
                    count += dfs(neighbourNode)
                }
            }
            return count
        }
    
        func findCount() {
            for index in 0..<n {
                if visited[index] == false {
                    let count = dfs(index)
                    countArray.append(count)
                    total += count
                }
            }
        }
    
        func multiplyCount() -> Int {
            guard countArray.count != 1 else { return 0 }
            
            var finalCount = 0
            for index in 0..<(countArray.count-1) {
                total -= countArray[index]
                finalCount += (countArray[index] * total)
            }
            return finalCount
        }
    
        buildGraph()
        findCount()
    
        return multiplyCount()
    }
}