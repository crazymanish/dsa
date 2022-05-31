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
    private var goodNodes = 0

    func goodNodes(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }

        findGoodNodes(root, currentPathMaxNode: root.val)

        return goodNodes
    }

    private func findGoodNodes(_ root: TreeNode?, currentPathMaxNode: Int) {
        guard let currentNode = root else { return }

        var newMaxNodeValue = currentPathMaxNode
        if currentNode.val >= currentPathMaxNode {
            newMaxNodeValue = currentNode.val

            goodNodes += 1
        }

        findGoodNodes(currentNode.left, currentPathMaxNode: newMaxNodeValue)
        findGoodNodes(currentNode.right, currentPathMaxNode: newMaxNodeValue)
    }
}