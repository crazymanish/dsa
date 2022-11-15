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
    func countNodes(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        
        // TC - log(N)
        func depth(of node: TreeNode?) -> Int {
            guard let node = node else { return 0 }
            
            return 1 + depth(of: node.left)
        }
        
        // The depth calls take O(logN)
        let leftDepth = depth(of:root.left)
        let rightDepth = depth(of:root.right)
        
        // At every step we would either be looking at the left or right subtree
        // so we would in total O(logN) calls and each call required O(logN) for the depth calculation
        // Therefore, the total complexity is O(logN*logN)
        if leftDepth == rightDepth {
            // If that is the case the left subtree is a perfect binary tree and the right subtree is complete
            return 2 << (leftDepth - 1) + countNodes(root.right)
        } else  {
            // leftDepth > rightDepth
            // Here the left subtree is a complete binary tree while the right subtree is a perfect binary tree
            return 2 << (rightDepth - 1) + countNodes(root.left)
        }
    }
}