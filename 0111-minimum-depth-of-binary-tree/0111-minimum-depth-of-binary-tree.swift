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
    func minDepth(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
    
        var minDepth = Int.max
        
        func findAllDepths(_ root: TreeNode?, _ currentDepth: Int) {
            guard let currentNode = root else { return }

            let newDepth = currentDepth + 1

            if currentNode.left == nil && currentNode.right == nil {
                minDepth = min(minDepth, newDepth)
            }

            findAllDepths(currentNode.left, newDepth)
            findAllDepths(currentNode.right, newDepth)
        }
        
        findAllDepths(root, 0)
        return minDepth
    }
}