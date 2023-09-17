class Solution {
    func shortestPathLength(_ graph: [[Int]]) -> Int {
        if graph.count == 0 || graph.count == 1 { return 0 }        
        
        var queue: [(currentNode:Int, mask:Int)] = []
        for index in 0..<graph.count {
            let element = (index, 1<<index)
            queue.append(element)  // Save Current Node along with Current Mask to Queue
        }
        
        var seen: Set<[Int]> = Set(queue.map{[$0.0, $0.1]}) // Add all Initial bfs nodes along with their initial mask to seen set
        var steps = 0 
        let endMask = (1<<graph.count)-1 
        
        while queue.count > 0 {        
            let count = queue.count 
            
            for _ in 0..<count {
                let currentElement = queue.removeFirst()
                let neighbours = graph[currentElement.0] ?? [] // Nodes reachable from Current Node
                
                for neighbour in neighbours {
                    let newMask =  currentElement.1 | (1<<neighbour) 
                    if newMask == endMask { // Mean we have visited all Nodes
                        return steps + 1
                    }
                    
                    let seenKey = [neighbour, newMask]
                    if seen.contains(seenKey) {
                        continue
                    }
                    seen.insert(seenKey)
                    
                    let newElement = (neighbour, newMask)
                    queue.append(newElement)
                }
            }
            
            steps += 1
        }
        
        return 0
    }
}