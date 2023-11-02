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
    func averageOfSubtree(_ root: TreeNode?) -> Int {
        var counter = 0
        
        func dfs(_ root: TreeNode?) -> (sum: Int, count: Int) { 
            guard let root = root else { return (0, 0) }
        
            let (left_sum, left_count) = dfs(root.left)
            let (right_sum, right_count) = dfs(root.right)
            
            let sum = left_sum + right_sum + root.val
            let count = left_count + right_count + 1
        
            if (root.val == sum / count) { 
                counter += 1 
            }
        
            return (sum, count)
        }
        
        dfs(root)
        return counter
    }
}