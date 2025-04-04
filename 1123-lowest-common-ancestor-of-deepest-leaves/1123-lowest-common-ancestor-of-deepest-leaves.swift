/**
 * Definition for a binary tree node.
 * public class TreeNode {
 * public var val: Int
 * public var left: TreeNode?
 * public var right: TreeNode?
 * public init() { self.val = 0; self.left = nil; self.right = nil; }
 * public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
 * public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
 * self.val = val
 * self.left = left
 * self.right = right
 * }
 * }
 */
class Solution {
    // Finds the LCA of the deepest leaves in a binary tree.
    func lcaDeepestLeaves(_ root: TreeNode?) -> TreeNode? {
        guard let root = root else { return nil } // Handle empty tree case

        // Nested function to calculate the maximum depth of the binary tree.
        func calculateTreeDepth(_ root: TreeNode?) -> Int {
            guard let node = root else { return 0 } // Base case: empty tree has depth 0

            let leftDepth = calculateTreeDepth(node.left) // Recursively calculate left subtree depth
            let rightDepth = calculateTreeDepth(node.right) // Recursively calculate right subtree depth

            return max(leftDepth, rightDepth) + 1 // Depth is max of subtrees + 1 for the current node
        }

        let maxDepth = calculateTreeDepth(root) - 1 // Calculate the maximum depth of the tree (0-indexed)

        // Nested function to recursively find the LCA of the deepest nodes.
        func findLcaOfDeepestNodes(_ root: TreeNode?, currentDepth: Int, maxDepth: Int) -> TreeNode? {
            guard let currentNode = root else { return nil } // Base case: empty node

            if currentDepth == maxDepth { return currentNode } // Base case: reached a deepest leaf node

            let nextDepth = currentDepth + 1 // Depth for the next level
            let leftLca = findLcaOfDeepestNodes(currentNode.left, currentDepth: nextDepth, maxDepth: maxDepth) // Recursively find LCA in left subtree
            let rightLca = findLcaOfDeepestNodes(currentNode.right, currentDepth: nextDepth, maxDepth: maxDepth) // Recursively find LCA in right subtree

            if leftLca != nil && rightLca != nil {
                return currentNode // Current node is the LCA if both subtrees have deepest leaves
            } else if leftLca != nil {
                return leftLca // Return the LCA of the left subtree if it exists
            } else {
                return rightLca // Otherwise, return the LCA of the right subtree (or nil if both are nil)
            }
        }

        return findLcaOfDeepestNodes(root, currentDepth: 0, maxDepth: maxDepth) // Find the LCA recursively
    }
}