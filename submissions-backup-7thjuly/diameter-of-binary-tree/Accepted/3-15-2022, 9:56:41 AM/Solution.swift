// https://leetcode.com/problems/diameter-of-binary-tree

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
    private var outputDiameter: Int = Int.min
    
    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        calculateDiameterOfBinaryTree(root)
        
        return outputDiameter - 1 // length
    }
    
    private func calculateDiameterOfBinaryTree(_ root: TreeNode?) -> Int {
        guard let currentNode = root else { return 0 }
        
        let leftDiameter = calculateDiameterOfBinaryTree(currentNode.left)
        let rightDiameter = calculateDiameterOfBinaryTree(currentNode.right)
        
        let currentNodeDiameter = max(leftDiameter, rightDiameter) + 1
        let possibleDiameter = max(currentNodeDiameter, 1 + leftDiameter + rightDiameter)
        
        outputDiameter = max(outputDiameter, possibleDiameter)
        
        return currentNodeDiameter
    }
}