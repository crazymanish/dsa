class Solution {
    // Enum to represent the state of each node
    enum NodeState: Int {
        case unknown = 0
        case unsafe = 1
        case safe = 2
    }
    
    func eventualSafeNodes(_ graph: [[Int]]) -> [Int] {
        let size = graph.count
        // Array to store the state of each node
        var colour = Array<NodeState>(repeating: .unknown, count: size)
        
        // Helper function to traverse the graph and determine if a node is safe
        func traverse(index: Int) -> Bool {
            // If the node state is already known, return if it's safe
            if colour[index] != .unknown {
                return colour[index] == .safe
            }
        
            // Mark the node as unsafe initially
            colour[index] = .unsafe
        
            // Traverse all adjacent nodes
            for neighbor in graph[index] {
                // If any adjacent node is unsafe or leads to an unsafe node, return false
                if colour[neighbor] == .unsafe || !traverse(index: neighbor) {
                    return false
                }
            }
            
            // Mark the node as safe if all adjacent nodes are safe
            colour[index] = .safe
            return true
        }
        
        var result = [Int]()
        // Check each node in the graph
        for i in 0..<size {
            // If the node is safe, add it to the result
            if traverse(index: i) {
                result.append(i)
            }
        }
        
        return result
    }
}