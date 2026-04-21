/**
 Problem Summary:
 ----------------
 Given two arrays `source` and `target`, and a list of allowed swaps between indices,
 we can swap elements in `source` only within connected components formed by `allowedSwaps`.

 The goal is to minimize the Hamming distance between `source` and `target`,
 i.e., count of indices where values differ.

 Strategy:
 ---------
 1. Use Union-Find to group indices that can be swapped freely.
 2. For each connected component:
    - Count frequency difference between `source` and `target`.
    - Any unmatched values contribute to Hamming distance.
 3. Sum all unmatched counts.

 Time Complexity:
 ----------------
 O(n α(n)) ≈ O(n)

 Space Complexity:
 -----------------
 O(n)
 */
class Solution {
    func minimumHammingDistance(_ source: [Int], _ target: [Int], _ allowedSwaps: [[Int]]) -> Int {
        
        let length = source.count
        let unionFind = UnionFind(length)

        // Step 1: Build connected components using allowed swaps
        for swap in allowedSwaps {
            let indexA = swap[0]
            let indexB = swap[1]
            unionFind.union(indexA, indexB)
        }

        // Step 2: Group indices by their root (component representative)
        var componentToIndices: [Int: [Int]] = [:]
        for index in 0..<length {
            let root = unionFind.find(index)
            componentToIndices[root, default: []].append(index)
        }

        var minimumHammingDistance = 0

        // Step 3: Process each component independently
        for indices in componentToIndices.values {
            
            // Frequency difference map:
            // +1 for source values, -1 for target values
            var valueFrequencyDiff: [Int: Int] = [:]

            for index in indices {
                let sourceValue = source[index]
                let targetValue = target[index]

                // Count source occurrences
                valueFrequencyDiff[sourceValue, default: 0] += 1
                
                // Subtract target occurrences
                valueFrequencyDiff[targetValue, default: 0] -= 1
            }

            // Remaining positive counts are unmatched values
            // Each contributes to Hamming distance
            for difference in valueFrequencyDiff.values where difference > 0 {
                minimumHammingDistance += difference
            }
        }

        return minimumHammingDistance
    }
}

class UnionFind {
    private var parent: [Int]
    private var componentSize: [Int]

    init(_ count: Int) {
        parent = Array(0..<count)
        componentSize = Array(repeating: 1, count: count)
    }

    /// Finds the root of a node with path compression
    func find(_ node: Int) -> Int {
        if parent[node] != node {
            parent[node] = find(parent[node]) // Path compression
        }
        return parent[node]
    }

    /// Unions two nodes by size
    func union(_ nodeA: Int, _ nodeB: Int) {
        var rootA = find(nodeA)
        var rootB = find(nodeB)

        // Already in same component
        if rootA == rootB { return }

        // Attach smaller component under larger one
        if componentSize[rootA] > componentSize[rootB] {
            swap(&rootA, &rootB)
        }

        parent[rootA] = rootB
        componentSize[rootB] += componentSize[rootA]
    }
}
