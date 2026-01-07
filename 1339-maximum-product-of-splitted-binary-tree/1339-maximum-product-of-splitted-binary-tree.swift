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
    ///   • O(n), where n = number of nodes in the tree
    ///     We perform a single DFS traversal.
    ///
    /// Space Complexity:
    ///   • O(n)
    ///     - Stores subtree sums for all nodes
    ///     - Recursion stack in the worst case
    ///
    /// Problem Summary:
    ///   Remove exactly one edge from the binary tree.
    ///   This splits the tree into two subtrees.
    ///   Maximize the product of the sums of the two resulting subtrees.
    ///
    /// Approach:
    ///   - Use DFS to compute the sum of every subtree.
    ///   - The total sum of the tree is known after DFS.
    ///   - For each subtree with sum `s`, the product is:
    ///         s * (totalSum - s)
    ///   - Track the maximum such product.
    /// -----------------------------------------------------------------------
    func maxProduct(_ root: TreeNode?) -> Int {
        let MOD = 1_000_000_007
        
        // Stores the sum of every subtree
        var allSubtreeSums: [Int] = []
        
        // DFS that returns the sum of the subtree rooted at `node`
        func computeSubtreeSum(_ node: TreeNode?) -> Int {
            guard let node = node else { return 0 }
            
            let leftSum = computeSubtreeSum(node.left)
            let rightSum = computeSubtreeSum(node.right)
            
            let subtreeSum = node.val + leftSum + rightSum
            allSubtreeSums.append(subtreeSum)
            
            return subtreeSum
        }
        
        // Total sum of the entire tree
        let totalTreeSum = computeSubtreeSum(root)
        
        var maxProductValue = 0
        
        // Try removing the edge above each subtree
        for subtreeSum in allSubtreeSums {
            let product = subtreeSum * (totalTreeSum - subtreeSum)
            maxProductValue = max(maxProductValue, product)
        }
        
        return maxProductValue % MOD
    }
}
