class Solution {
    func shortestAlternatingPaths(_ n: Int, _ redEdges: [[Int]], _ blueEdges: [[Int]]) -> [Int] {
        // visited, last edge is red / blue
        var visitedRed = Array(repeating: false, count: n)
        var visitedBlue = Array(repeating: false, count: n)
        
        var result = Array(repeating: -1, count: n)
        result[0] = 0
        
        var pathLength = -1
        
        // (index, last edge is red)
        var queue = [(Int, Bool)]()
        queue.append((0, true))
        queue.append((0, false))
        
        while !queue.isEmpty {
            pathLength += 1
            
            let count = queue.count
            for _ in 0..<count {
                let element = queue.removeFirst()
                if result[element.0] == -1 {
                    result[element.0] = pathLength
                }
                
                // last red
                if element.1 {
                    visitedRed[element.0] = true
                    
                    for edge in blueEdges {
                        if edge[0] == element.0, !visitedBlue[edge[1]] {
                            queue.append((edge[1], false))
                        }
                    }
                } else {
                    visitedBlue[element.0] = true
                    
                    for edge in redEdges {
                        if edge[0] == element.0, !visitedRed[edge[1]] {
                            queue.append((edge[1], true))
                        }
                    }
                }
            }
        }
        
        return result
    }
    
}