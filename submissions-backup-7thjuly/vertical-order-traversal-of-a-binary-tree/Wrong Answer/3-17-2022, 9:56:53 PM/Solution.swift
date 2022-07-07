// https://leetcode.com/problems/vertical-order-traversal-of-a-binary-tree

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
    func verticalTraversal(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else { return [[]] }
        
        var depthWithValuesMap: [Int: [Int]] = [:]
        let queue = Queue<NodeInfo>()
        queue.enQueue(NodeInfo(root, 0))
        
        while queue.isEmpty == false {
            let currentNodeInfo = queue.deQueue()!
            let currentNode = currentNodeInfo.node
            let currentDepth = currentNodeInfo.depth
            
           if let currentDepthMap = depthWithValuesMap[currentDepth] {
                var newArray = currentDepthMap + [currentNode.val]
                newArray.sort()
                depthWithValuesMap[currentDepth] = newArray
            } else {
                depthWithValuesMap[currentDepth] = [currentNode.val]
            }
            
            if let leftNode = currentNode.left {
                queue.enQueue(NodeInfo(leftNode, currentDepth-1))
            } 
            
            if let rightNode = currentNode.right {
                queue.enQueue(NodeInfo(rightNode, currentDepth+1))
            } 
        }
        
        var outputArray: [[Int]] = []
        
        let sortedData = depthWithValuesMap.sorted(by: { $0.key < $1.key })
        
        for (_, value) in sortedData {
            outputArray.append(value)
        }
        
        return outputArray
    }
}

class NodeInfo {
    let node: TreeNode
    let depth: Int
    
    init(_ node: TreeNode, _ depth: Int) {
        self.node = node
        self.depth = depth
    }
}

class Queue<T> {
    private var array: [T] = []

    var isEmpty: Bool { return array.isEmpty }

    func enQueue(_ value: T) {
        array.append(value)
    }

    func deQueue() -> T? {
        if isEmpty { return nil }

        return array.removeFirst()
    }
}
