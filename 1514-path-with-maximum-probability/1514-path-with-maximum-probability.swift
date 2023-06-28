class Solution {
    // The time complexity for bellmann ford is O(EV)
    // for all vertices we relax all edges
    func maxProbability(_ n: Int, _ edges: [[Int]], _ succProb: [Double], _ start: Int, _ end: Int) -> Double {
        var adjacencyList = [Int:[(Int, Double)]]()
        for (index,edge) in edges.enumerated() {
            adjacencyList[edge[0], default:[]].append((edge[1], succProb[index]))
            adjacencyList[edge[1], default:[]].append((edge[0], succProb[index]))
        }
        
        var probabilityMap = [Int:Double]()
        for vertex in 0..<n {
            probabilityMap[vertex] = 0.0
        }
        probabilityMap[start] = 1.0
        
        var queue = [start]
        while !queue.isEmpty {
            var nextQueue = [Int]()
            for vertex in queue {
                for neighbor in adjacencyList[vertex, default:[]] {
                    if probabilityMap[neighbor.0]! < probabilityMap[vertex]! * neighbor.1 {
                        probabilityMap[neighbor.0] = probabilityMap[vertex]! * neighbor.1
                        nextQueue.append(neighbor.0)
                    }
                }
            }
            queue = nextQueue
        }
        
        return probabilityMap[end]!
    }
}