import Algorithms
import Collections

class Solution {
    func modifiedGraphEdges(_ n: Int, _ edges: [[Int]], _ source: Int, _ destination: Int, _ target: Int) -> [[Int]] {
        let maxW = Int(1e9)

        // build graph, excluding w=-1. graph[from] -> [(to, weight)]
        var graph = Array(repeating: [(Int,Int)](), count: n)
        product(edges,0...1).forEach{e,i in graph[e[i]] += e[2]>0 ? [(e[i^1],e[2])]:[]}

        // Dijkstra's algorithm
        let shortestDistanceFromTarget : ()->Int = { 
            struct Node: Comparable {
                var v, w: Int
                static func < (l:Node, r:Node) -> Bool { l.w < r.w }
            }
            var heap = Heap([Node(v:source, w:0)])
            var minDist = Array(repeating: maxW, count: n)
            while let node = heap.popMin()  {
                guard node.w <= minDist[node.v] else { continue }
                for (v,w) in graph[node.v] where w + node.w < minDist[v] {
                    minDist[v] = w + node.w
                    heap.insert(Node(v:v, w:minDist[v]))
                }
            }
            return target - minDist[destination]
        }
        
        // analyze incoming graph
        let delta = shortestDistanceFromTarget()
        guard delta <= 0 else { return [] } // no solution
        
        // replace all -1's, use `maxW` for edges not included in shortest path
        var atTarget = delta == 0
        var edges = edges 
        for (i,e) in edges.enumerated() where edges[i][2] == -1 {
            guard !atTarget else { edges[i][2] = maxW; continue } 
            // insert edge
            graph[e[0]].append((e[1], 1))
            graph[e[1]].append((e[0], 1))
            // recalculate distance needed to reach target
            let minDist = shortestDistanceFromTarget() + 1
            atTarget = minDist > 0
            edges[i][2] = max(minDist, 1)
        }
        return atTarget ? edges : []
    }
}