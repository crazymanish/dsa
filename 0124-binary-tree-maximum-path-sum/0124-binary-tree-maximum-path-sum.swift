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
    func maxPathSum(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }

        var maxPathSum: Int = Int.min
        
        func findPathSum(_ root: TreeNode?) -> Int {
            guard let currentNode = root else { return 0 }

            let leftPathSum = findPathSum(currentNode.left)
            let rightPathSum = findPathSum(currentNode.right)

            let currentPathSum = max((max(leftPathSum, rightPathSum) + currentNode.val), currentNode.val)
            let possibleMaxPathSum = max(currentPathSum, leftPathSum + rightPathSum + currentNode.val)
             maxPathSum = max(maxPathSum, possibleMaxPathSum)

            return currentPathSum
        }
        
        
        findPathSum(root)
        return maxPathSum
    }
}