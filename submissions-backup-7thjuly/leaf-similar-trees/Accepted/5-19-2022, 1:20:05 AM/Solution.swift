// https://leetcode.com/problems/leaf-similar-trees

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
    func leafSimilar(_ root1: TreeNode?, _ root2: TreeNode?) -> Bool {
        guard let root1 = root1, let root2 = root2 else { return false }

        let leftLeafNodes = leafNodes(root1)
        let rightLeafNodes = leafNodes(root2)

        return leftLeafNodes == rightLeafNodes
    }

    private func leafNodes(_ root: TreeNode?) -> [Int] {
        guard let rootNode = root else { return [] }

        if rootNode.left == nil && rootNode.right == nil { return [rootNode.val] }

        let leftLeafNodes = leafNodes(rootNode.left)
        let rightLeafNodes = leafNodes(rootNode.right)

        return leftLeafNodes + rightLeafNodes
    }
}