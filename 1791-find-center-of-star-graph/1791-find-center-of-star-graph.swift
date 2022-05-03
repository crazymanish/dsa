class Solution {
    func findCenter(_ edges: [[Int]]) -> Int {
        // Idea: All edges must have a common node, which will be the center/answer.
        
        var hashMap: [Int: Int] = [:] // Frequency count of each node
        
        for edge in edges {
            let sourceNode = edge[0]
            let destinationNode = edge[1]
            
            hashMap[sourceNode] = (hashMap[sourceNode] ?? 0) + 1
            hashMap[destinationNode] = (hashMap[destinationNode] ?? 0) + 1
        }
        
        let edgesCount = edges.count
        var answer = 0
        for (key, value) in hashMap {
            if value == edgesCount {
                answer = key
                break
            }
        }
        
        return answer
    }
}