// https://leetcode.com/problems/sum-of-nodes-with-even-valued-grandparent

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
    private var grandparentNodeSum = 0
    
    func sumEvenGrandparent(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        
        calculateEvenGrandparent(root)
        
        return grandparentNodeSum
    }
    
    private func calculateEvenGrandparent(_ root: TreeNode?) {
        guard let currentNode = root else { return }
        
        let currentNodeValue = currentNode.val
        let isCurrentNodeEven = currentNodeValue % 2 == 0
        
        if isCurrentNodeEven {
            if let leftLeftGrandchild = currentNode.left?.left {
                grandparentNodeSum += leftLeftGrandchild.val
            }
            
            if let leftRightGrandchild = currentNode.left?.right {
                grandparentNodeSum += leftRightGrandchild.val
            }
            
            if let rightLeftGrandchild = currentNode.right?.left {
                grandparentNodeSum += rightLeftGrandchild.val
            }
            
            if let rightRightGrandchild = currentNode.right?.right {
                grandparentNodeSum += rightRightGrandchild.val
            }
        } 
        
        calculateEvenGrandparent(currentNode.left)
        calculateEvenGrandparent(currentNode.right)
    }
}