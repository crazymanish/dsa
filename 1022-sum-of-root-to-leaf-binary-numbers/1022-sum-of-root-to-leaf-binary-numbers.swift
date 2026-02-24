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
    /// Problem Summary:
    ///   Each root-to-leaf path forms a binary number.
    ///   Return the sum of all those binary numbers.
    ///
    /// Example:
    ///   Tree:      1
    ///             / \
    ///            0   1
    ///
    ///   Paths:
    ///       10 (2)
    ///       11 (3)
    ///
    ///   Output: 5
    ///
    /// Strategy:
    ///   - Perform DFS.
    ///   - Build the current binary number using bit shifting:
    ///         newValue = (previousValue << 1) | node.val
    ///   - When reaching a leaf, add the number to the total.
    ///
    /// Time Complexity:
    ///   • O(n)
    ///     Each node is visited once.
    ///
    /// Space Complexity:
    ///   • O(h)
    ///     h = tree height (recursion stack).
    /// -----------------------------------------------------------------------
    func sumRootToLeaf(_ root: TreeNode?) -> Int {
        return dfs(root, 0)
    }

    private func dfs(_ node: TreeNode?, _ currentValue: Int) -> Int {
        guard let node = node else { return 0 }

        // Build binary number so far
        let updatedValue = (currentValue << 1) | node.val

        // If leaf node, return the completed binary number
        if node.left == nil && node.right == nil {
            return updatedValue
        }

        // Otherwise, continue DFS
        return dfs(node.left, updatedValue) + dfs(node.right, updatedValue)
    }
}