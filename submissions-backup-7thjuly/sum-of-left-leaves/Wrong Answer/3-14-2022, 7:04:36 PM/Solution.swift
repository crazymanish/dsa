// https://leetcode.com/problems/sum-of-left-leaves

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
    func sumOfLeftLeaves(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }

        var outputSum = 0
        let queue = Queue()
        queue.enQueue(root)
        
        while queue.isEmpty == false {
            let currentNode = queue.deQueue()!
            
            if let leftNode = currentNode.left {
                queue.enQueue(leftNode)
                
                outputSum += leftNode.val
            }
            
            if let rightNode = currentNode.right {
                queue.enQueue(rightNode)
            }
        }
        
        return outputSum
    }
}

class Queue {
    private var array: [TreeNode] = []

    var isEmpty: Bool { return array.isEmpty }

    func enQueue(_ element: TreeNode) {
        array.append(element)
    }
    
    func deQueue() -> TreeNode? {
        guard isEmpty == false else { return nil }
        
        return array.removeFirst()
    }
}