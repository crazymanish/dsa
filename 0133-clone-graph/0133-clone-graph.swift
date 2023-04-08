/**
 * Definition for a Node.
 * public class Node {
 *     public var val: Int
 *     public var neighbors: [Node?]
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.neighbors = []
 *     }
 * }
 */

class Solution {
    func cloneGraph(_ node: Node?) -> Node? {
        guard let node = node else { return nil }
        
        var queue: [Node] = [node]
        var visited: [Node: Node] = [:]
        visited[node] = Node(node.val)
        
        while queue.count > 0 {
            let node = queue.removeFirst()
            
            for neighbor in node.neighbors.compactMap{ $0 } {
                if visited[neighbor] == nil {
                   visited[neighbor] = Node(neighbor.val)
                   queue.append(neighbor)
                }
                visited[node]?.neighbors.append(visited[neighbor])
            }
        }
        
        return visited[node]
    }
}