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
    ///     - Inorder traversal visits each node once.
    ///     - Rebuilding the balanced BST also visits each node once.
    ///
    /// Space Complexity:
    ///   • O(n)
    ///     - Stores all nodes in an array (in sorted order).
    ///     - Recursion stack is O(h) where h ≤ n, but dominated by O(n) array.
    ///
    /// Problem Summary:
    ///   Given a BST, rebuild it into a height-balanced BST while preserving
    ///   the in-order (sorted) sequence of values.
    ///
    /// Approach:
    ///   1) Inorder traversal of the BST gives nodes in sorted order.
    ///   2) Build a balanced BST from the sorted node list using the middle
    ///      element as root (classic "sorted array to BST").
    /// -----------------------------------------------------------------------
    func balanceBST(_ root: TreeNode?) -> TreeNode? {
        // Collect nodes in sorted order using inorder traversal.
        var inorderNodes = [TreeNode]()
        
        func inorderTraversal(_ node: TreeNode?) {
            guard let node = node else { return }
            inorderTraversal(node.left)
            inorderNodes.append(node)
            inorderTraversal(node.right)
        }
        
        // Build a balanced BST from sorted nodes [start...end].
        func buildBalancedBST(_ nodes: [TreeNode], _ start: Int, _ end: Int) -> TreeNode? {
            guard start <= end else { return nil }
            
            let midIndex = (start + end) / 2
            let rootNode = nodes[midIndex]
            
            // Reassign children to reflect the balanced structure.
            rootNode.left = buildBalancedBST(nodes, start, midIndex - 1)
            rootNode.right = buildBalancedBST(nodes, midIndex + 1, end)
            
            return rootNode
        }
        
        inorderTraversal(root)
        return buildBalancedBST(inorderNodes, 0, inorderNodes.count - 1)
    }
}
