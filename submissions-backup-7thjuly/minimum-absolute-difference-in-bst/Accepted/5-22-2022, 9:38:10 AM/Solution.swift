// https://leetcode.com/problems/minimum-absolute-difference-in-bst

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
    private var minimumDifference = Int.max
    private var previousNode: TreeNode? = nil
    
    func getMinimumDifference(_ root: TreeNode?) -> Int {
        findMinimumDifference(root)
        
        return minimumDifference
    }
    
    private func findMinimumDifference(_ currentNode: TreeNode?) {
        guard let currentNode = currentNode else { return }
        
        findMinimumDifference(currentNode.left)
        
        if previousNode != nil {
            let currentDifference = abs(previousNode!.val - currentNode.val)
            minimumDifference = min(minimumDifference, currentDifference)
        }
        
        previousNode = currentNode
        
        findMinimumDifference(currentNode.right)
    }
}