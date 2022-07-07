// https://leetcode.com/problems/merge-two-binary-trees

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
    func mergeTrees(_ root1: TreeNode?, _ root2: TreeNode?) -> TreeNode? {
        if root1 == nil && root2 == nil { return nil }

        if root1 == nil { return root2 }
        if root2 == nil { return root1 }


        let leftMerge = mergeTrees(root1?.left, root2?.left)
        let rightMerge = mergeTrees(root1?.right, root2?.right)

        return TreeNode(root1!.val + root2!.val, leftMerge, rightMerge)
    }
}