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
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        guard let root = root, let p = p, let q = q else { return nil }

        return findLowestLCA(root, p.val, q.val)
    }

    private func findLowestLCA(_ root: TreeNode?, _ p: Int, _ q: Int) -> TreeNode? {
        guard let currentNode = root else { return nil }

        if currentNode.val == p || currentNode.val == q { return currentNode }

        let leftLowestLCA = findLowestLCA(currentNode.left, p, q)
        let rightLowestLCA = findLowestLCA(currentNode.right, p, q)

        if leftLowestLCA != nil && rightLowestLCA != nil { return currentNode }
        if leftLowestLCA != nil { return leftLowestLCA }
        if rightLowestLCA != nil { return rightLowestLCA }

        return nil
    }
}