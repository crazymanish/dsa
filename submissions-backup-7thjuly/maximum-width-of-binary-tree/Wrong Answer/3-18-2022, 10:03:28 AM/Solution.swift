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
        queue.enQueue(NodeInfo(root, 1))
        
        while queue.isEmpty == false {
            var currentLevelNodeInfos: [NodeInfo] = []
            
            while queue.isEmpty == false {
                let currentNodeInfo = queue.deQueue()!
                currentLevelNodeInfos.append(currentNodeInfo)
            }
            
            var currentLevelWidth = currentLevelNodeInfos.last!.width
            maxWidth = max(maxWidth, currentLevelWidth)
            
            for nodeInfo in currentLevelNodeInfos {
                if let leftNode = nodeInfo.node.left {
                    queue.enQueue(NodeInfo(leftNode, (nodeInfo.width*2)-1))
                }
                
                if let rightNode = nodeInfo.node.right {
                    queue.enQueue(NodeInfo(rightNode, (nodeInfo.width*2)))
                }
            }
        }
        
        
        return maxWidth
    }
}

private extension TreeNode {
    var isLeafNode: Bool { left == nil && right == nil }
}

class NodeInfo {
    let node: TreeNode
    let width: Int
    
    init(_ node: TreeNode, _ width: Int) {
        self.node = node
        self.width = width
    }
}

class Queue {
    private var array: [NodeInfo] = []
    
    var isEmpty: Bool { array.isEmpty }
    
    func enQueue(_ element: NodeInfo) {
        array.append(element)
    }
    
    func deQueue() -> NodeInfo? {
        if isEmpty { return nil }
        
        return array.removeFirst()
    }
}