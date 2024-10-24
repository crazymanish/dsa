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
    func flipEquiv(_ root1: TreeNode?, _ root2: TreeNode?) -> Bool {
        if root1 == nil && root2 == nil { return true }
        if root1 == nil || root2 == nil { return false }
        if root1!.val != root2!.val { return false }
        
        // Assume, there is flip
        let isLeftFlipEquiv = flipEquiv(root1!.left, root2!.right)
        let isRightFlipEquiv = flipEquiv(root1!.right, root2!.left)
        let isFlipEquiv = isLeftFlipEquiv && isRightFlipEquiv
        
        // Assume, no flip
        let isLeftNotFlipEquiv = flipEquiv(root1!.left, root2!.left)
        let isRightNotFlipEquiv = flipEquiv(root1!.right, root2!.right)
        let isNotFlipEquiv = isLeftNotFlipEquiv && isRightNotFlipEquiv
        
        return isFlipEquiv || isNotFlipEquiv
    }
}