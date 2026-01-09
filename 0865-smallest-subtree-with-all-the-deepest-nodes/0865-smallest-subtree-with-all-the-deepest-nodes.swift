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
    ///   • O(n)
    ///     - First DFS computes the maximum depth.
    ///     - Second DFS finds the lowest common ancestor (LCA) of all deepest nodes.
    ///
    /// Space Complexity:
    ///   • O(h)
    ///     - h = height of the tree (recursion stack).
    ///
    /// Problem Summary:
    ///   Return the smallest subtree that contains all the deepest nodes
    ///   in the binary tree.
    ///
    /// Approach:
    ///   1. Compute the maximum depth of the tree.
    ///   2. Perform a second DFS to find the lowest node that contains
    ///      all nodes at that maximum depth.
    /// -----------------------------------------------------------------------
    func subtreeWithAllDeepest(_ root: TreeNode?) -> TreeNode? {
        guard let rootNode = root else { return nil }
        
        // Maximum depth of the tree (0-based indexing)
        let deepestLevel = computeMaxDepth(rootNode) - 1
        
        // Find the lowest common ancestor of all deepest nodes
        return findDeepestSubtreeRoot(
            from: rootNode,
            currentDepth: 0,
            targetDepth: deepestLevel
        )
    }
    
    /// Computes the maximum depth of the tree.
    private func computeMaxDepth(_ node: TreeNode?) -> Int {
        guard let node = node else { return 0 }
        
        let leftDepth = computeMaxDepth(node.left)
        let rightDepth = computeMaxDepth(node.right)
        
        return max(leftDepth, rightDepth) + 1
    }
    
    /// Finds the lowest node that contains all nodes at the target depth.
    private func findDeepestSubtreeRoot(
        from node: TreeNode?,
        currentDepth: Int,
        targetDepth: Int
    ) -> TreeNode? {
        guard let node = node else { return nil }
        
        // If we have reached the deepest level, return this node
        if currentDepth == targetDepth {
            return node
        }
        
        let nextDepth = currentDepth + 1
        
        // Search both subtrees
        let leftResult = findDeepestSubtreeRoot(
            from: node.left,
            currentDepth: nextDepth,
            targetDepth: targetDepth
        )
        
        let rightResult = findDeepestSubtreeRoot(
            from: node.right,
            currentDepth: nextDepth,
            targetDepth: targetDepth
        )
        
        // If deepest nodes are found in both subtrees,
        // current node is their lowest common ancestor
        if leftResult != nil && rightResult != nil {
            return node
        }
        
        // Otherwise, propagate the non-nil result upward
        return leftResult ?? rightResult
    }
}
