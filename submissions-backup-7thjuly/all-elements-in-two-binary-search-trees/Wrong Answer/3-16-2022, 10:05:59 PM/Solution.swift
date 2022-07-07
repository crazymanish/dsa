// https://leetcode.com/problems/all-elements-in-two-binary-search-trees

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
    func getAllElements(_ root1: TreeNode?, _ root2: TreeNode?) -> [Int] {
        if root1 == nil && root2 == nil { return [] }
        
        if root1 == nil { return [root2!.val] }
        if root2 == nil { return [root1!.val] }
        

        let leftElements = getAllElements(root1?.left, root2?.left)
        let rightElements = getAllElements(root1?.right, root2?.right)
        
        if root1!.val <= root2!.val {
            return leftElements + [root1!.val, root2!.val] + rightElements   
        } else {
            return leftElements + [root2!.val, root1!.val]  + rightElements
        }
    }
}