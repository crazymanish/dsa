class Solution {
    func restoreArray(_ adjacentPairs: [[Int]]) -> [Int] {
        var map: [Int: [Int]] = [:]

        for pair in adjacentPairs {
            map[pair[0], default: []].append(pair[1])
            map[pair[1], default: []].append(pair[0])
        }

        var startNode = 0 // first node whole value count is 1
        // there will be 2 nodes with values 1 either be start and end
        for (key, value) in map {
            if value.count == 1 {
                startNode = key
                break
            }
        }

        var dfsNodes = [startNode] // start with very first node
        var visited: Set<Int> = []
        var results: [Int] = []

        while !dfsNodes.isEmpty {
            let element = dfsNodes.removeLast()
            
            if visited.contains(element) { continue }
            visited.insert(element)
            
            results.append(element)
            
            for node in map[element] ?? [] {
                dfsNodes.append(node)
            }
        }

        return results
    }
}