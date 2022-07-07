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
        
        let leftTilt = findTilt(currentNode.left)
        let rightTilt = findTilt(currentNode.right)
        
        let leftChildsSum = findSum(currentNode.left)
        let rightChildsSum = findSum(currentNode.right)
        let currentNodeTilt = abs(leftChildsSum-rightChildsSum)
        
        return currentNodeTilt + leftTilt + rightTilt
    }
    
    private func findSum(_ root: TreeNode?) -> Int {
        guard let currentNode = root else { return 0 }

        let leftSum = findSum(currentNode.left)
        let rightSum = findSum(currentNode.right)

        let currentNodeSum = currentNode.val
        
        return currentNodeSum + leftSum + rightSum
    }
}