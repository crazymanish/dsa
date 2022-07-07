// https://leetcode.com/problems/all-nodes-distance-k-in-binary-tree

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.left = nil
 *         self.right = nil
 *     }
 * }
 */
class Solution {
    func distanceK(_ root: TreeNode?, _ target: TreeNode?, _ k: Int) -> [Int] {
        guard let root = root, let target = target else { return [] }

        var depthWithValuesMap: [Int: [Int]] = [:]
        var targetNodeDepth: Int!
        let queue = Queue<NodeInfo>()
        queue.enQueue(NodeInfo(root, 0))

        while queue.isEmpty == false {
            let currentNodeInfo = queue.deQueue()!
            let currentNode = currentNodeInfo.node
            let currentDepth = currentNodeInfo.depth
            let absDepth = abs(currentDepth)

            if currentNode.val == target.val { 
                targetNodeDepth = absDepth 
            } else {
                if let currentDepthMap = depthWithValuesMap[absDepth] {
                    depthWithValuesMap[absDepth] = currentDepthMap + [currentNode.val]
                } else {
                    depthWithValuesMap[absDepth] = [currentNode.val]
                }   
            }

            if let leftNode = currentNode.left {
                queue.enQueue(NodeInfo(leftNode, currentDepth-1))
            }

            if let rightNode = currentNode.right {
                queue.enQueue(NodeInfo(rightNode, currentDepth+1))
            }
        }
        
        print(depthWithValuesMap)
        print(targetNodeDepth)

        return depthWithValuesMap[abs(k)-targetNodeDepth] ?? []
    }
}

private class NodeInfo {
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
