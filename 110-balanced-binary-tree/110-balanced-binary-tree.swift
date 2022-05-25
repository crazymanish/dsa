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
    func isBalanced(_ root: TreeNode?) -> Bool {
        guard let currentNode = root else { return true }

        let leftHeight = height(currentNode.left)
        let rightHeight = height(currentNode.right)

        if abs(leftHeight - rightHeight) > 1 { return false }

        return isBalanced(currentNode.left) && isBalanced(currentNode.right)
    }

    private func height(_ root: TreeNode?) -> Int {
        guard let currentNode = root else { return 0 }

        let leftHeight = height(currentNode.left)
        let rightHeight = height(currentNode.right)

        return 1 + max(leftHeight, rightHeight)
    }
}
