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

        var depthWithValuesMap: [Int: [NodeInfo]] = [:]
        let queue = Queue<NodeInfo>()
        queue.enQueue(NodeInfo(root, 0, 0))

        while queue.isEmpty == false {
            let currentNodeInfo = queue.deQueue()!
            let currentNode = currentNodeInfo.node
            let currentRow = currentNodeInfo.row
            let currentColumn = currentNodeInfo.column

            if let currentDepthMap = depthWithValuesMap[currentColumn] {
                depthWithValuesMap[currentColumn] = currentDepthMap + [currentNodeInfo]
            } else {
                depthWithValuesMap[currentColumn] = [currentNodeInfo]
            }

            if let leftNode = currentNode.left {
                queue.enQueue(NodeInfo(leftNode, currentRow+1, currentColumn-1))
            }

            if let rightNode = currentNode.right {
                queue.enQueue(NodeInfo(rightNode, currentRow+1, currentColumn+1))
            }
        }

        var outputArray: [[Int]] = []
        let sortedMap = depthWithValuesMap.sorted(by: { $0.key < $1.key })

        for (_, value) in sortedMap {
            let sortedValues = value.sorted {
                if $0.row == $1.row { return $0.node.val < $1.node.val }
                return $0.column < $1.column
            }

            let intValues = sortedValues.map { $0.node.val }
            outputArray.append(intValues)
        }

        return outputArray
    }
}

class NodeInfo {
    let node: TreeNode
    let row: Int
    let column: Int

    init(_ node: TreeNode, _ row: Int, _ column: Int) {
        self.node = node
        self.row = row
        self.column = column
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
