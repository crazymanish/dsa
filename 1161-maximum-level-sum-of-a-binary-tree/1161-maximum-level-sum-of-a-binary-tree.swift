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
    func maxLevelSum(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        
        var maxLevelSum = 0
        var currentLevel = 1
        var maxCurrentSum = Int64.min
        let queue = Queue()
        queue.enQueue(root)
        
        while queue.isEmpty == false {
            var currentSum: Int64 = 0
            let queueCount = queue.count
            
            for _ in 0..<queueCount {
                let currentNode = queue.deQueue()!
                
                currentSum += Int64(currentNode.val)
                
                if let leftNode = currentNode.left { queue.enQueue(leftNode) }
                if let rightNode = currentNode.right { queue.enQueue(rightNode) }   
            }
            
            if currentSum > maxCurrentSum {
                maxCurrentSum = currentSum
                maxLevelSum = currentLevel
            }
            currentLevel += 1
        }
        
        return maxLevelSum
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