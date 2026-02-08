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
    /// -----------------------------------------------------------------------
    /// Time Complexity:
    ///   • Worst case: O(n²)
    ///     - For each node, we compute the height of its subtrees.
    ///     - Height computation itself is O(n) in the worst case.
    ///
    /// Space Complexity:
    ///   • O(h)
    ///     - h = height of the tree (recursion stack).
    ///
    /// Problem Summary:
    ///   A binary tree is height-balanced if, for every node,
    ///   the height difference between its left and right subtrees
    ///   is at most 1.
    ///
    /// Approach:
    ///   - For each node:
    ///       • Compute the height of its left subtree.
    ///       • Compute the height of its right subtree.
    ///       • Check the balance condition.
    ///   - Recursively verify the same condition for both subtrees.
    /// -----------------------------------------------------------------------
    func isBalanced(_ root: TreeNode?) -> Bool {
        guard let node = root else { return true }
        
        let leftSubtreeHeight = computeHeight(node.left)
        let rightSubtreeHeight = computeHeight(node.right)
        
        // Current node must satisfy height difference ≤ 1
        if abs(leftSubtreeHeight - rightSubtreeHeight) > 1 {
            return false
        }
        
        // Both subtrees must also be balanced
        return isBalanced(node.left) && isBalanced(node.right)
    }
    
    /// Computes the height of a binary tree.
    private func computeHeight(_ node: TreeNode?) -> Int {
        guard let node = node else { return 0 }
        
        let leftHeight = computeHeight(node.left)
        let rightHeight = computeHeight(node.right)
        
        return 1 + max(leftHeight, rightHeight)
    }
}
