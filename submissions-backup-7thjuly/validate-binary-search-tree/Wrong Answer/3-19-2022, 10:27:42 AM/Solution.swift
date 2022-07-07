// https://leetcode.com/problems/validate-binary-search-tree

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
    func isValidBST(_ root: TreeNode?) -> Bool {
        guard let currentNode = root else { return false }
        
        if currentNode.isLeafNode { return true }
        
        if let leftNode = currentNode.left, let rightNode = currentNode.right {
            return leftNode.val < currentNode.val && rightNode.val > currentNode.val
        }
        
        if let leftNode = currentNode.left {
            return leftNode.val < currentNode.val
        }
        
        if let rightNode = currentNode.right {
            return rightNode.val > currentNode.val
        }
        
        let isLeftValidBST = isValidBST(currentNode.left)
        let isRightValidBST = isValidBST(currentNode.right)
        
        return isLeftValidBST && isRightValidBST
    }
}

private extension TreeNode {
    var isLeafNode: Bool { left == nil && right == nil }
}