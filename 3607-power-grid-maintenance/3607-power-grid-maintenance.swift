// Time Complexity: O((n + q) * α(n))
// Space Complexity: O(n)
// where α(n) is the inverse Ackermann function (almost constant in practice)

class Solution {
  func processQueries(_ n: Int, _ connections: [[Int]], _ queries: [[Int]]) -> [Int] {
    // Initialize parent array for Disjoint Set Union (Union-Find)
    var parent = Array(0...n)
    
    // Find function with path compression optimization
    func find(_ node: Int) -> Int {
      if parent[node] != node {
        parent[node] = find(parent[node]) // recursively find and compress path
      }
      return parent[node]
    }

    // Union step: connect the given pairs of nodes
    for connection in connections {
      let rootA = find(connection[0])
      let rootB = find(connection[1])
      parent[rootA] = rootB
    }

    // Path compression for all nodes to ensure flat structure
    for i in 1...n {
      find(i)
    }

    // Build mapping from root → set of its members
    var componentMembers = parent.indexed().reduce(into: [Int: Set<Int>]()) { dict, entry in
      let (index, root) = entry
      dict[root, default: .init()].insert(index)
    }

    // Process each query
    return queries.compactMap { query in
      let type = query[0]
      let node = query[1]
      let root = find(node)

      if type == 2 {
        // Type 2: remove node from its component
        componentMembers[root]?.remove(node)
        return nil
      }

      // Type 1: return node if still active, else smallest remaining in its component
      return componentMembers[root]?.contains(node) == true
        ? node
        : componentMembers[root]?.min() ?? -1
    }
  }
}
