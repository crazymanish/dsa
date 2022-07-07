// https://leetcode.com/problems/two-sum-iv-input-is-a-bst

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
    func findTarget(_ root: TreeNode?, _ k: Int) -> Bool {
        guard let root = root else { return false }
        
        let remainingTarget = k - root.val
        
        if remainingTarget < root.val {
            return isElementExist(root.left, remainingTarget)
        } else {
            return isElementExist(root.right, remainingTarget)
        }
        
        let findTargetInLeft = findTarget(root.left, k)
        let findTargetInRight = findTarget(root.right, k)
        
        return findTargetInLeft || findTargetInRight
    }
    
    private func isElementExist(_ root: TreeNode?, _ k: Int) -> Bool {
        guard let root = root else { return false }
        
        if root.val == k { return true }
        
        let isElementExistInLeft = isElementExist(root.left, k)
        let isElementExistInRight = isElementExist(root.right, k)
        
        return isElementExistInLeft || isElementExistInRight
    }
}