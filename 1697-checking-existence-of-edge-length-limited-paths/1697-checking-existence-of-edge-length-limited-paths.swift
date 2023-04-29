class Solution {
    func distanceLimitedPathsExist(_ n: Int, _ edgeList: [[Int]], _ queries: [[Int]]) -> [Bool] {
        var graph = Array(0 ..< n)
        let edges = edgeList.sorted { $0[2] < $1[2] }
        let sortedQueries = queries.enumerated().sorted { $0.1[2] < $1.1[2] }
    
        func searchParent(_ edge: Int) -> Int {
            if graph[edge] == edge { return edge }
            
            graph[edge] = searchParent(graph[edge])
            return graph[edge]
        }
        
        var result = Array(repeating: false, count: queries.count)
        var edgeCount = 0
        for (index, query) in sortedQueries {
            let limit = query[2]
            while edgeCount < edges.count {
                let edge = edges[edgeCount]
                if edge[2] >= limit { break }
                
                edgeCount += 1
                
                let parent0 = searchParent(edge[0])
                let parent1 = searchParent(edge[1])
                if parent0 != parent1 { graph[parent0] = parent1 }
            }
            
            if searchParent(query[0]) == searchParent(query[1]) {
                result[index] = true
            }
        }
        
        return result
    }
}