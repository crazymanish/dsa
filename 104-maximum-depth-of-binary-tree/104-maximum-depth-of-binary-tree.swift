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
    var maxDepth = 0
    
    func maxDepth(_ root: TreeNode?) -> Int {
        findMaxDepth(root, 0)
        
        return maxDepth
    }
    
    private func findMaxDepth(_ root: TreeNode?, _ currentDepth: Int) {
        if root == nil { return }
        
        let newCurrentDepth = currentDepth + 1

        if root?.left == nil && root?.right == nil {
            maxDepth = max(maxDepth, newCurrentDepth)
        } else {
            findMaxDepth(root?.left, newCurrentDepth)
            findMaxDepth(root?.right, newCurrentDepth)
        }
    }
}