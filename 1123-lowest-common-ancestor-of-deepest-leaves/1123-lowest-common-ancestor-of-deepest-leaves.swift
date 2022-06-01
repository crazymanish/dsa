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
    func lcaDeepestLeaves(_ root: TreeNode?) -> TreeNode? {
        guard let root = root else { return nil }
        let maximumDepth = calculateDepth(root) - 1

        return findLcaNode(root, 0, maximumDepth)
    }

    private func calculateDepth(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }

        let leftHeight = calculateDepth(root.left)
        let rightHeight = calculateDepth(root.right)

        return max(leftHeight, rightHeight) + 1
    }

    private func findLcaNode(_ root: TreeNode?, _ currentDepth: Int, _ maximumDepth: Int) -> TreeNode? {
        guard let currentNode = root else { return nil }

        if currentDepth == maximumDepth { return currentNode }

        let newDepth = currentDepth + 1
        let leftLcaNode = findLcaNode(currentNode.left, newDepth, maximumDepth)
        let rightLcaNode = findLcaNode(currentNode.right, newDepth, maximumDepth)

        if leftLcaNode != nil && rightLcaNode != nil {
            return currentNode
        } else if leftLcaNode != nil {
            return leftLcaNode
        } else {
            return rightLcaNode
        }
    }
}
