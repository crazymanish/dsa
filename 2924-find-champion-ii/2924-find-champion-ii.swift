class Solution {
    func findChampion(_ n: Int, _ edges: [[Int]]) -> Int {
        var visited = Set<Int>()
        
        for edge in edges {
            visited.insert(edge[1])
        }
        
        if visited.count + 1 == n {
            for i in 0..<n {
                if !visited.contains(i) {
                    return i
                }
            }
        } 

        return -1
    }
}