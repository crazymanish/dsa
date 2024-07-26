class Solution {
    func findTheCity(_ n: Int, _ edges: [[Int]], _ distanceThreshold: Int) -> Int {
        var paths = Array(
            repeating: Array(repeating: Int.max, count: n),
            count: n
        )

        for i in 0..<n { paths[i][i] = 0 }
        
        for edge in edges {
            paths[edge[0]][edge[1]] = edge[2]
            paths[edge[1]][edge[0]] = edge[2]
        }

        for k in 0..<n {
            for i in 0..<n
                where paths[i][k] != Int.max {
                    for j in 0..<n
                        where paths[k][j] != Int.max {
                            paths[i][j] = min(paths[i][j], paths[i][k] + paths[k][j])
                        }
                }
        }

        let counts = paths.map { $0.filter({ $0 <= distanceThreshold }).count }
        let tgt = counts.min()!

        return counts.lastIndex(of: tgt)!
    }
}