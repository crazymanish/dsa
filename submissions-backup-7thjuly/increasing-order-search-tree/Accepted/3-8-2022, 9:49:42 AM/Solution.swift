// https://leetcode.com/problems/increasing-order-search-tree

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

class Queue {
    private var array: [Int] = []

    var isEmpty: Bool { return array.isEmpty }

    func enQueue(_ value: Int) {
        array.append(value)
    }

    func deQueue() -> Int? {
        if isEmpty { return nil }

        return array.removeFirst()
    }
}

class Solution {
    func increasingBST(_ root: TreeNode?) -> TreeNode? {
        if root == nil { return nil }

        let queue = Queue()
        getAllBSTNodes(root, queue: queue)

        var outputNode: TreeNode? = TreeNode(-1)
        let outputRootNode = outputNode

        while queue.isEmpty == false {
            let newNode = TreeNode(queue.deQueue()!)
            outputNode?.right = newNode
            outputNode = outputNode?.right
        }

        return outputRootNode?.right
    }

    func getAllBSTNodes(_ root: TreeNode?, queue: Queue) {
        if root == nil { return }

        getAllBSTNodes(root?.left, queue: queue)
        queue.enQueue(root!.val)
        getAllBSTNodes(root?.right, queue: queue)
    }
}