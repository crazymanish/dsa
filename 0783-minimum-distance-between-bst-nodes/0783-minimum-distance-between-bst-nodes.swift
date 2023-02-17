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
    func minDiffInBST(_ root: TreeNode?) -> Int {
        var minimumDifference = Int.max
        var previousNode: TreeNode? = nil
        
        func calculateMinimumDifferenceUsingInorderTraversalInBST(_ root: TreeNode?) {
            guard let currentNode = root else { return }
        
            calculateMinimumDifferenceUsingInorderTraversalInBST(currentNode.left)
        
            if let previousNode = previousNode {
                let currentNodeDifference = abs(previousNode.val - currentNode.val)
                minimumDifference = min(minimumDifference, currentNodeDifference)
            }
        
            previousNode = currentNode
        
            calculateMinimumDifferenceUsingInorderTraversalInBST(currentNode.right)
        }
        
        calculateMinimumDifferenceUsingInorderTraversalInBST(root)
        return minimumDifference
    }
}