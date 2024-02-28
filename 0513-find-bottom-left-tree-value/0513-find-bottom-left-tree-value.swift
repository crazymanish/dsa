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
    func findBottomLeftValue(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        
        var leftMostValue = 0
        let queue = Queue()
        queue.enQueue(root)
        
        while queue.isEmpty == false {
            let queueCount = queue.count
            
            for index in 0..<queueCount {
                let currentNode = queue.deQueue()!
                
                if index == 0 { leftMostValue = currentNode.val }
                
                if let leftNode = currentNode.left { queue.enQueue(leftNode) }
                if let rightNode = currentNode.right { queue.enQueue(rightNode) }
            }
        }
        
        return leftMostValue
    }
}

class Queue {
    private var array: [TreeNode] = []
    
    var isEmpty: Bool { array.isEmpty }
    
    var count: Int { array.count }
    
    func enQueue(_ element: TreeNode) {
        array.append(element)
    }
    
    func deQueue() -> TreeNode? {
        if isEmpty { return nil }
        
        return array.removeFirst()
    }
}