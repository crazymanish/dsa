// https://leetcode.com/problems/univalued-binary-tree

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
    func isUnivalTree(_ root: TreeNode?) -> Bool {
        guard let rootNode = root else { return true }
        
        if let left = rootNode.left, 
            let right = rootNode.right, 
            left.val == rootNode.val,
            right.val == rootNode.val {
                return true
            }
        
        let isLeftUnivalTree = isUnivalTree(rootNode.left)
        let isRightUnivalTree = isUnivalTree(rootNode.right)
        
        return isLeftUnivalTree && isRightUnivalTree
    }
}