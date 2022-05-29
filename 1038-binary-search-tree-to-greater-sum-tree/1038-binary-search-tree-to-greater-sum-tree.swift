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
    private var tempValue = 0

    func bstToGst(_ root: TreeNode?) -> TreeNode? {
        convertBstToGst(root)

        return root
    }

    private func convertBstToGst(_ root: TreeNode?) {
        guard let currentNode = root else { return }

        convertBstToGst(currentNode.right)

        tempValue += currentNode.val
        currentNode.val = tempValue

        convertBstToGst(currentNode.left)
    }
}