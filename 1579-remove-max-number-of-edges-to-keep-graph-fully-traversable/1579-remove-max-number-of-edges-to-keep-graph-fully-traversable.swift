class UnionFind {
    var root: [Int] = []
    var rank: [Int] = []
    var group: Int = 0
    
    init(_ group: Int) {
        self.group = group
        
        for i in 0..<group {
            root.append(i)
            rank.append(1)
        }
    }
    
    func find(_ x: Int) -> Int {
        if x != root[x] {
            root[x] = find(root[x])
        }
        
        return root[x]
    }
    
    func union(_ x: Int, _ y: Int) -> Bool {
        let rootX = find(x)
        let rootY = find(y)
        
        if rootX != rootY {
            group -= 1
            
            if rank[rootX] < rank[rootY] {
                root[rootX] = rootY
            } else if rank[rootX] > rank[rootY] {
                root[rootY] = rootX
            } else {
                root[rootY] = rootX
                rank[rootY] += 1
            }
            
            return true
        }
        
        return false
    }
}

class Solution {
    // Time: O(klogn) k is number of edge
    // Space: O(n)
    func maxNumEdgesToRemove(_ n: Int, _ edges: [[Int]]) -> Int {
        let alice = UnionFind(n)
        let bob = UnionFind(n)
        var requiredEdges = edges.count
        
        for edge in edges {
            let type = edge[0]
            let node1 = edge[1] - 1
            let node2 = edge[2] - 1
            if type == 3 {
                let requiredAlice = alice.union(node1, node2)
                let requiredBob = bob.union(node1, node2)
                
                if requiredAlice || requiredBob {
                    requiredEdges -= 1
                }
            }
        }
        
        for edge in edges {
            let type = edge[0]
            let node1 = edge[1] - 1
            let node2 = edge[2] - 1
            if type == 1 {
                if alice.union(node1, node2) {
                    requiredEdges -= 1
                }
            } else if type == 2 {
                if bob.union(node1, node2) {
                    requiredEdges -= 1
                }
            }
        }
        
        if alice.group > 1 || bob.group > 1 { return -1 }
        return requiredEdges
    }
}