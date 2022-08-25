class Solution {
    struct Pair: Hashable {
        var x: Int
        var y: Int
    }
    
    var directions: [Character: Pair] = [:]

    func isPathCrossing(_ path: String) -> Bool {
        directions["N"] = Pair(x: 0, y: -1)
        directions["S"] = Pair(x: 0, y: 1)
        directions["E"] = Pair(x: 1, y: 0)
        directions["W"] = Pair(x: -1, y: 0)
        
        var current = Pair(x: 0, y: 0)
        var visited: Set<Pair> = [current]
        
        for character in path {
            if let direction = directions[character] {
                current = Pair(x: current.x + direction.x, y: current.y + direction.y)
                if visited.contains(current) {
                    return true
                }
                visited.insert(current)
            }
        }
        
        return false
    }
}