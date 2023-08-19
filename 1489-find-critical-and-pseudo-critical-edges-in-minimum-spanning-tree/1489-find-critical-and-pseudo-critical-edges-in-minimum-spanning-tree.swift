class Solution {
    func findCriticalAndPseudoCriticalEdges(_ n: Int, _ edges: [[Int]]) -> [[Int]] {
        var sortedEdges = edges.enumerated().map { ($0, $1[0], $1[1], $1[2]) }
        sortedEdges.sort { $0.3 < $1.3 }
    
        let totalWeight = MSTWeight(n, sortedEdges, nil, nil)
        var criticalEdges: [Int] = []
        var pseudoCriticalEdges: [Int] = []
    
        for i in 0..<sortedEdges.count {
            let weightWithoutI = MSTWeight(n, sortedEdges, i, nil)
            if weightWithoutI > totalWeight {
                criticalEdges.append(sortedEdges[i].0)
                continue
            }
        
            let weightWithI = MSTWeight(n, sortedEdges, nil, i)
            if weightWithI == totalWeight {
                pseudoCriticalEdges.append(sortedEdges[i].0)
            }
        }
    
        return [criticalEdges, pseudoCriticalEdges]
    }

    func MSTWeight(_ n: Int, _ edges: [(Int, Int, Int, Int)], _ skip: Int?, _ pick: Int?) -> Int {
        var parents = [Int](repeating: 0, count: n)
            
        func find(_ x: Int) -> Int {
            if parents[x] != x {
                parents[x] = find(parents[x])
            }
            return parents[x]
        }

        func union(_ x: Int, _ y: Int) {
            let rootX = find(x)
            let rootY = find(y)
    
            if rootX != rootY {
                parents[rootY] = rootX
            }
        }
        
        
        for i in 0..<n {
            parents[i] = i
        }
    
        var weight = 0
        var count = 1
    
        if let pick = pick {
            union(edges[pick].1, edges[pick].2)
            weight += edges[pick].3
            count += 1
        }
    
        for i in 0..<edges.count {
            if skip != nil && i == skip { continue }
            
            let (u, v, w) = (edges[i].1, edges[i].2, edges[i].3)
            let h1 = find(u)
            let h2 = find(v)
            if h1 != h2 {
                parents[h1] = h2
                weight += w
                count += 1
            }
        }
    
        return count == n ? weight : Int.max
    }
}

/*
class Solution {
    struct GraphEdge: Hashable {
        let firstNode: Int
        let weight: Int
        let secondNode: Int
    }
    
    func findCriticalAndPseudoCriticalEdges(_ n: Int, _ edges: [[Int]]) -> [[Int]] {
        // ascending edge weight to find the minumum overall weight
        let sortedEdges = edges.sorted { $0[2] < $1[2] }
        
        // indicies must be returned in the initial order, so we store these edges and their order
        var positionDictionary: [GraphEdge: Int] = [:]
        for edge in 0..<edges.count {
            let graphEdge = GraphEdge(firstNode: edges[edge][0], weight: edges[edge][1], secondNode: edges[edge][2])
            positionDictionary[graphEdge] = edge
        }
        
        // chosen edge, exclude
        func calculateDistance(selectedEdge: Int, exclude: Int) -> Int {
            let edges = sortedEdges
            var parents: [Int] = Array(0...n)
            var cost = 0
            var count = 0
        
            if (selectedEdge != -1) {
                let edge = edges[selectedEdge]
                parents[edge[0]] = parents[edge[1]]
                
                cost += edge[2]
                count += 1
            }
            
            // basic union find
            func unionFind(edge: Int) -> Int {
                if(parents[edge] != edge) {
                    return unionFind(edge: parents[edge])
                }
            
                return edge
            }
        
            // for each edge
            for i in 0..<edges.count {
                // do not take into account the excluded edge
                if (i == exclude) { continue }
            
                let root1 = unionFind(edge: edges[i][0])
                let root2 = unionFind(edge: edges[i][1])
                if (root1 != root2) {
                    parents[root1] = root2
                    count += 1
                
                    // the cost if the node is not part of the network
                    cost += edges[i][2]
                }
            }
        
            if (count == n - 1) {
                return cost
            } else {
                return Int.max
            }
        }
        
        // Calculate MST
        let minWeight = calculateDistance(selectedEdge: -1, exclude: -1)
        
        // Output Array
        var output: [[Int]] = [[],[]]
        
        // for each edge
        for edge in 0..<sortedEdges.count {
            // we use the original (sorted index
            let graphEdge = GraphEdge(firstNode: edges[edge][0], weight: edges[edge][1], secondNode: edges[edge][2])
            let index = positionDictionary[graphEdge]!
            
            if calculateDistance(selectedEdge: -1, exclude: edge) > minWeight {
                output[0].append(index)
            } else {
                if calculateDistance(selectedEdge: edge, exclude: -1) == minWeight {
                    output[1].append(index)
                }
            }
        }
        return output
    }
}
*/