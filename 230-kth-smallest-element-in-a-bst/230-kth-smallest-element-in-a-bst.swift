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
    func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
        guard let root = root else { return 0 }
        
        let allElements = inorderTraversal(root)
        
        return allElements[k-1]
    }
    
    private func inorderTraversal(_ root: TreeNode?) -> [Int] {
        guard let currentNode = root else { return [] }
        
        let leftInorderTraversal = inorderTraversal(currentNode.left)
        let rightInorderTraversal = inorderTraversal(currentNode.right)

        return leftInorderTraversal + [currentNode.val] + rightInorderTraversal
    }
}