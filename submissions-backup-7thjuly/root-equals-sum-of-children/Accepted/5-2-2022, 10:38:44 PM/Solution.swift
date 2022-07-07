// https://leetcode.com/problems/root-equals-sum-of-children

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
    func checkTree(_ root: TreeNode?) -> Bool {
        let rootValue = root?.val ?? 0
        let leftChildValue = root?.left?.val ?? 0
        let rightChildValue = root?.right?.val ?? 0
        
        return rootValue == leftChildValue+rightChildValue
    }
}