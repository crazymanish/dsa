/**
 Problem Summary
 ----------------
 We are given an undirected graph with `n` nodes and edges described as:

    [u, v, weight, mandatoryFlag]

 - `u`, `v` → endpoints
 - `weight` → stability value
 - `mandatoryFlag`
        1 = edge must be included
        0 = optional edge

We must construct a spanning tree that:
1. Includes all mandatory edges.
2. Connects all nodes.
3. Allows upgrading up to `k` optional edges (doubling their weight).

The stability of the resulting network is defined as the **minimum edge weight in the tree**.
Our goal is to **maximize this minimum stability**.

If it's impossible to build a valid spanning tree, return `-1`.

 Strategy
 --------
 1. Separate edges into:
    - mandatory edges
    - optional edges

 2. Build a spanning forest using Union-Find:
    - Add mandatory edges first.
    - If any mandatory edge forms a cycle → impossible.

 3. Add optional edges in **descending weight order** (greedy MST-style).

 4. Track weights of chosen optional edges.

 5. After building the spanning tree:
    - Greedily apply up to `k` upgrades to the **smallest edges**
      (processed from smallest to largest).

 6. The final stability is the minimum weight edge in the tree.

 Time Complexity
 ----------------
 O(E log E) due to sorting optional edges.

 Space Complexity
 ----------------
 O(N + E) for Union-Find structures and edge storage.
 */

class Solution {
    func maxStability(_ n: Int, _ edges: [[Int]], _ k: Int) -> Int {
        // Separate edges into mandatory and optional groups
        var mandatoryEdges: [[Int]] = []
        var optionalEdges: [[Int]] = []

        for edge in edges {
            if edge[3] == 1 {
                mandatoryEdges.append(edge)
            } else {
                optionalEdges.append(edge)
            }
        }

        // Sort optional edges by descending weight (greedy preference)
        optionalEdges.sort { $0[2] > $1[2] }

        // Union-Find initialization
        var parent = Array(0..<n)
        var componentSize = Array(repeating: 1, count: n)
        var numberOfSets = n

        // Path compression find
        func find(_ node: Int) -> Int {
            if parent[node] != node {
                parent[node] = find(parent[node])
            }
            return parent[node]
        }

        // Union by size
        func union(_ a: Int, _ b: Int) -> Bool {
            let rootA = find(a)
            let rootB = find(b)

            if rootA == rootB {
                return false   // would create cycle
            }

            if componentSize[rootA] > componentSize[rootB] {
                parent[rootB] = rootA
                componentSize[rootA] += componentSize[rootB]
            } else {
                parent[rootA] = rootB
                componentSize[rootB] += componentSize[rootA]
            }

            numberOfSets -= 1
            return true
        }

        // Track minimum edge weight in the tree
        var minimumStability = Int.max

        // Add mandatory edges first
        for edge in mandatoryEdges {

            let u = edge[0]
            let v = edge[1]
            let weight = edge[2]

            // Mandatory edge forming a cycle → impossible
            guard union(u, v) else { return -1 }

            minimumStability = min(minimumStability, weight)
        }

        // Add optional edges greedily (largest weight first)
        var chosenOptionalWeights: [Int] = []

        for edge in optionalEdges {

            let u = edge[0]
            let v = edge[1]
            let weight = edge[2]

            // Skip edges that create cycles
            guard union(u, v) else { continue }

            chosenOptionalWeights.append(weight)
        }

        // Graph must be fully connected
        guard numberOfSets == 1 else { return -1 }

        // Greedily upgrade the smallest edges
        var upgradesUsed = 0

        for weight in chosenOptionalWeights.reversed() {

            if upgradesUsed < k {
                minimumStability = min(weight * 2, minimumStability)
                upgradesUsed += 1
            } else {
                minimumStability = min(weight, minimumStability)
            }
        }

        return minimumStability
    }
}