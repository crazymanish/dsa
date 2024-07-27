class Solution {
    func minimumCost(_ source: String, _ target: String, _ original: [Character], _ changed: [Character], _ cost: [Int]) -> Int {
        let inf = Int.max
        var distance = Array(repeating: Array(repeating: inf, count: 26), count: 26)

        // Initialize distance matrix with self-transformation costs
        for i in 0..<26 {
            distance[i][i] = 0
        }

        // Set the initial transformation costs
        for i in 0..<original.count {
            let before = Int(original[i].asciiValue!) - 97
            let after = Int(changed[i].asciiValue!) - 97
            let cost = cost[i]
            distance[before][after] = min(distance[before][after], cost)
        }

        // Apply Floyd-Warshall algorithm to find all-pairs shortest path
        for k in 0..<26 {
            for i in 0..<26 {
                for j in 0..<26 {
                    if distance[i][k] != inf, distance[k][j] != inf {
                        distance[i][j] = min(distance[i][j], distance[i][k] + distance[k][j])
                    }
                }
            }
        }

        var totalCost = 0
        
        // Calculate the total transformation cost from source to target
        for (beforeChar, afterChar) in zip(source, target) {
            let before = Int(beforeChar.asciiValue!) - 97
            let after = Int(afterChar.asciiValue!) - 97

            // If transformation is impossible, return -1
            if distance[before][after] == inf {
                return -1
            }
            totalCost += distance[before][after]
        }

        return totalCost
    }
}