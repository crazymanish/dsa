// https://leetcode.com/problems/maximum-width-of-binary-tree

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
    func widthOfBinaryTree(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        
        var maxWidth = Int.min
        let queue = Queue()
        queue.enQueue(NodeInfo(root, 0))
        
        while queue.isEmpty == false {
            var firstNodeInfoIndex: Int64 = 0
            var lastNodeInfoIndex: Int64 = 0
            let currentLevelStartingIndex = queue.front!.index
            let currentLevelNodeCount = queue.count
            
            for i in 0..<currentLevelNodeCount {
                let currentNodeInfo = queue.deQueue()!
                let currentNodeIndex = currentNodeInfo.index - currentLevelStartingIndex
                
                if i == 0 { firstNodeInfoIndex = currentNodeIndex }
                if i == currentLevelNodeCount-1 { lastNodeInfoIndex = currentNodeIndex }
                
                let newIndex = (currentNodeIndex*2)
                
                if let leftNode = currentNodeInfo.node.left {
                    queue.enQueue(NodeInfo(leftNode, newIndex))
                }
                
                if let rightNode = currentNodeInfo.node.right {
                    queue.enQueue(NodeInfo(rightNode, newIndex+1))
                }
            }
            
            let currentLevelWidth = Int(lastNodeInfoIndex - firstNodeInfoIndex + 1)
            maxWidth = max(maxWidth, currentLevelWidth)
        }
        
        return maxWidth
    }
}

struct NodeInfo {
    let node: TreeNode
    let index: Int64
    
    init(_ node: TreeNode, _ index: Int64) {
        self.node = node
        self.index = index
    }
}

class Queue {
    private var array: [NodeInfo] = []
    
    var isEmpty: Bool { array.isEmpty }
    
    var count: Int { array.count }
    
    var front: NodeInfo? { array.first }
    
    func enQueue(_ element: NodeInfo) {
        array.append(element)
    }
    
    func deQueue() -> NodeInfo? {
        if isEmpty { return nil }
        
        return array.removeFirst()
    }
}