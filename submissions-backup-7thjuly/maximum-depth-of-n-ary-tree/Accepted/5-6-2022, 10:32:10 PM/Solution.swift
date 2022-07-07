// https://leetcode.com/problems/maximum-depth-of-n-ary-tree

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
    func maxDepth(_ root: Node?) -> Int {
        guard let rootNode = root else { return 0 }
        
        let queue = Queue()
        queue.enQueue(rootNode)
        
        var maxDepth = 0
        
        while queue.isEmpty == false {
            let queueCount = queue.count
            
            for _ in 0..<queueCount {
                let currentNode = queue.deQueue()!
                
                for childNode in currentNode.children {
                    queue.enQueue(childNode)
                }
            }
            
            maxDepth += 1
        }
        
        return maxDepth
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