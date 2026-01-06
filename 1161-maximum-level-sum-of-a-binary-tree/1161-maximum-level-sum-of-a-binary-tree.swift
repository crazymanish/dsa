/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init() { self.val = 0; self.left = nil; self.right = nil; }
 *     public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
 *     public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
 *         self.val = val
 *         self.left = left
 *         self.right = right
 *     }
 * }
 */

class Solution {
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • O(n), where n = number of nodes in the tree
    ///     Each node is visited exactly once.
    ///
    /// Space Complexity:
    ///   • O(n)
    ///     Queue may hold up to an entire level of the tree in the worst case.
    ///
    /// Problem Summary:
    ///   Find the level (1-indexed) of a binary tree that has the maximum
    ///   sum of node values. If multiple levels have the same maximum sum,
    ///   return the smallest level number.
    ///
    /// Approach:
    ///   - Use Breadth-First Search (level-order traversal).
    ///   - For each level:
    ///       • Compute the sum of node values.
    ///       • Compare it against the maximum seen so far.
    /// -----------------------------------------------------------------------
    func maxLevelSum(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        
        var bestLevel = 1
        var currentLevel = 1
        var maxSum: Int64 = Int64.min
        
        let queue = TreeNodeQueue()
        queue.enqueue(root)
        
        // Perform level-order traversal
        while !queue.isEmpty {
            let levelNodeCount = queue.count
            var levelSum: Int64 = 0
            
            // Process all nodes at the current level
            for _ in 0..<levelNodeCount {
                guard let node = queue.dequeue() else { continue }
                
                levelSum += Int64(node.val)
                
                if let left = node.left {
                    queue.enqueue(left)
                }
                if let right = node.right {
                    queue.enqueue(right)
                }
            }
            
            // Update maximum sum and corresponding level
            if levelSum > maxSum {
                maxSum = levelSum
                bestLevel = currentLevel
            }
            
            currentLevel += 1
        }
        
        return bestLevel
    }
}

class TreeNodeQueue {
    private var elements: [TreeNode] = []
    private var headIndex: Int = 0
    
    var isEmpty: Bool {
        return headIndex >= elements.count
    }
    
    var count: Int {
        return elements.count - headIndex
    }
    
    func enqueue(_ node: TreeNode) {
        elements.append(node)
    }
    
    func dequeue() -> TreeNode? {
        guard !isEmpty else { return nil }
        
        let node = elements[headIndex]
        headIndex += 1
        
        // Periodically clean up the array to avoid memory growth
        if headIndex > 50 {
            elements.removeFirst(headIndex)
            headIndex = 0
        }
        
        return node
    }
}
