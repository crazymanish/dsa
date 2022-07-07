// https://leetcode.com/problems/two-sum-iv-input-is-a-bst

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
    var treeNodeValuesMap: [Int : Bool] = [:]
    
    func findTarget(_ root: TreeNode?, _ k: Int) -> Bool {
        guard let root = root else { return false }
        
        let currentNodeValue = root.val
        let remainingTarget = k - currentNodeValue
        
        if treeNodeValuesMap[remainingTarget] != nil { return true }
        
        treeNodeValuesMap[currentNodeValue] = true
        
        let findTargetInLeft = findTarget(root.left, k)
        let findTargetInRight = findTarget(root.right, k)
        
        return findTargetInLeft || findTargetInRight
    }
}