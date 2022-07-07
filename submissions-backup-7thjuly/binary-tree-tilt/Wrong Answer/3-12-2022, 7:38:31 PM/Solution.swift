// https://leetcode.com/problems/binary-tree-tilt

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
    func findTilt(_ root: TreeNode?) -> Int {
        guard let currentNode = root else { return 0 }

        let leftChildValue = currentNode.left?.val ?? 0
        let rightChildValue = currentNode.right?.val ?? 0
        let currentNodeTilt = abs(leftChildValue-rightChildValue)
        
        let leftTilt = findTilt(currentNode.left)
        let rightTilt = findTilt(currentNode.right)
        
        return currentNodeTilt + leftTilt + rightTilt
    }
}