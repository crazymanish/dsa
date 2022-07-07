// https://leetcode.com/problems/subtree-of-another-tree

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
    func isSubtree(_ root: TreeNode?, _ subRoot: TreeNode?) -> Bool {
        guard let root = root, let subRoot = subRoot else { return false }

        let queue = Queue<TreeNode>()
        queue.enQueue(root)

        var isEqualTreeFound: Bool = false

        while queue.isEmpty == false {
            let currentNode = queue.deQueue()!

            if currentNode.val == subRoot.val && isEqualTree(currentNode, subRoot) {
                isEqualTreeFound = true
                break
            }

            if let leftNode = currentNode.left { queue.enQueue(leftNode) }
            if let rightNode = currentNode.right { queue.enQueue(rightNode) }
        }

        return isEqualTreeFound
    }

    private func isEqualTree(_ root1: TreeNode?, _ root2: TreeNode?) -> Bool {
        if root1 == nil, root2 == nil { return true }

        guard let root1 = root1, let root2 = root2 else { return false }

        let isleftEqualTree = isEqualTree(root1.left, root2.left)
        let isRightEqualTree = isEqualTree(root1.right, root2.right)

        return root1.val == root2.val && isleftEqualTree && isRightEqualTree
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
