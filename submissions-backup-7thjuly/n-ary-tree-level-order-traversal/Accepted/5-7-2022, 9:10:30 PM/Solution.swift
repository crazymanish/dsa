// https://leetcode.com/problems/n-ary-tree-level-order-traversal

/**
 * Definition for a Node.
 * public class Node {
 *     public var val: Int
 *     public var children: [Node]
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.children = []
 *     }
 * }
 */

class Solution {
    func levelOrder(_ root: Node?) -> [[Int]] {
        guard let rootNode = root else { return [] }
        
        var output: [[Int]] = []
        
        let queue = Queue()
        queue.enQueue(rootNode)
        
        while queue.isEmpty == false {
            let queueCount = queue.count
            var currentLevelNodeValues: [Int] = []
            
            for _ in 0..<queueCount {
                let currentNode = queue.deQueue()!
                
                currentLevelNodeValues.append(currentNode.val)
                
                for childNode in currentNode.children {
                    queue.enQueue(childNode)
                }
            }
            
            output.append(currentLevelNodeValues)
        }
        
        return output
    }
}

class Queue {
    private var array: [Node] = []
    
    var isEmpty: Bool { array.isEmpty }
    var count: Int { array.count }
    
    func enQueue(_ element: Node) {
        array.append(element)
    }
    
    func deQueue() -> Node? {
        if isEmpty { return nil }
        
        return array.removeFirst()
    }
}