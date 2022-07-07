// https://leetcode.com/problems/validate-binary-search-tree

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
    func isValidBST(_ root: TreeNode?) -> Bool {
        guard let currentNode = root else { return false }
        
        return findValidBST(root)
    }
    
    private func findValidBST(_ root: TreeNode?, _ minLeft: Int = Int.min, _ maxRight: Int = Int.max) -> Bool {
        guard let currentNode = root else { return true }
        
        let currentNodeValue = currentNode.val
        
        let isLeftValidBST = findValidBST(currentNode.left, minLeft, currentNodeValue)
        let isRightValidBST = findValidBST(currentNode.right, currentNodeValue, maxRight)
        
        let isCurrentBST = minLeft < currentNodeValue && currentNodeValue < maxRight
        
        return isCurrentBST && isLeftValidBST && isRightValidBST
    }    
}
