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
    func reverseOddLevels(_ root: TreeNode?) -> TreeNode? {
        func dfs(_ left: TreeNode?, _ right: TreeNode?, _ level: Int) {
            guard let leftNode = left, let rightNode = right else { return }
        
            if level % 2 == 1 {
                (leftNode.val, rightNode.val) = (rightNode.val, leftNode.val)
            }
        
            dfs(leftNode.left, rightNode.right, level + 1)
            dfs(leftNode.right, rightNode.left, level + 1)        
        }
        
        dfs(root?.left, root?.right, 1)
        return root
    }
}