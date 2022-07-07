// https://leetcode.com/problems/even-odd-tree

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
    func isEvenOddTree(_ root: TreeNode?) -> Bool {
        guard let rootNode = root else { return false }
        
        let queue = Queue()
        queue.enQueue(rootNode)
        
        var levelIndex = 0
        
        while queue.isEmpty == false {
            let queueCount = queue.count
            let isEvenLevelIndex = levelIndex % 2 == 0
            var previousValue = isEvenLevelIndex ? Int.min : Int.max
            
            for _ in 0..<queueCount {
                let currentNode = queue.deQueue()!
                let currentNodeValue = currentNode.val
                let isEvenNodeValue = currentNodeValue % 2 == 0
                
                if isEvenLevelIndex && isEvenNodeValue == false && currentNodeValue > previousValue {
                    previousValue = currentNodeValue
                } else if isEvenLevelIndex == false && isEvenNodeValue && currentNodeValue < previousValue {
                    previousValue = currentNodeValue
                } else {
                    return false
                }
                
                if let leftNode = currentNode.left { queue.enQueue(leftNode) }
                if let rightNode = currentNode.right { queue.enQueue(rightNode) }
            }
            
            levelIndex += 1
        }
        
        return true
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