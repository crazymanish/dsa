// https://leetcode.com/problems/binary-tree-pruning

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
    func pruneTree(_ root: TreeNode?) -> TreeNode? {
        guard let currentNode = root else { return nil }

        if currentNode.val == 0 && currentNode.isLeafNode { return nil }

        let leftPruneTree = pruneTree(currentNode.left)
        let rightPruneTree = pruneTree(currentNode.right)
        
        if currentNode.val == 0 && leftPruneTree == nil && rightPruneTree == nil { return nil }

        return TreeNode(currentNode.val, leftPruneTree, rightPruneTree)
    }
}

private extension TreeNode {
    var isLeafNode: Bool { left == nil && right == nil }
}