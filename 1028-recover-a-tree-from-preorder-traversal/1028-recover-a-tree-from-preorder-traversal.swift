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
    func recoverFromPreorder(_ traversal: String) -> TreeNode? {
        // Extract node values and their depths
        var values = traversal.split(separator: "-").compactMap { Int($0) }
        var depths = [0] + traversal.split(whereSeparator: { $0 != "-" }).map { String($0).count }

        var index = 0

        // Nested dfs function
        func dfs(depth: Int, parent: TreeNode) {
            index += 1 // Move to the next node

            // Process left subtree (inline)
            if index < depths.count && depths[index] == depth {
                let node = TreeNode(values[index])
                dfs(depth: depth + 1, parent: node) // Recursively build left subtree
                parent.left = node
            }

            // Process right subtree (inline)
            if index < depths.count && depths[index] == depth {
                let node = TreeNode(values[index])
                dfs(depth: depth + 1, parent: node) // Recursively build right subtree
                parent.right = node
            }
        }

        let root = TreeNode(values[0]) // Create the root node
        dfs(depth: 1, parent: root) // Build the tree recursively
        return root
    }
}