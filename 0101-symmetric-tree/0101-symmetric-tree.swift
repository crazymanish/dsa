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
    func isSymmetric(_ root: TreeNode?) -> Bool {
        guard let currentNode = root else { return false }
        
        func leftFirstTraversal(_ root: TreeNode?) -> String {
            guard let currentNode = root else { return "-" }

            let left = leftFirstTraversal(currentNode.left)
            let right = leftFirstTraversal(currentNode.right)

            return "\(currentNode.val)" + left + right
        }

        func rightFirstTraversal(_ root: TreeNode?) -> String {
            guard let currentNode = root else { return "-" }

            let left = rightFirstTraversal(currentNode.left)
            let right = rightFirstTraversal(currentNode.right)

            return "\(currentNode.val)" + right + left
        }

        let leftFirstTraversal = leftFirstTraversal(currentNode.left)
        let rightFirstTraversal = rightFirstTraversal(currentNode.right)

        return leftFirstTraversal == rightFirstTraversal
    }
}