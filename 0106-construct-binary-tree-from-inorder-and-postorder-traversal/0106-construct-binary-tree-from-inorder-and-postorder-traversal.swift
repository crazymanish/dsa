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
    func buildTree(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
        var postorderIndex = postorder.count

        func makeTree(_ start: Int, _ end: Int) -> TreeNode? {
            postorderIndex -= 1
            
            guard let rootIndex = (inorder.firstIndex { $0 == postorder[postorderIndex] }) else { return nil }
            
            let value = postorder[postorderIndex]

            // Don't call recursive makeTree if `rootIndex < end` or `rootIndex > start`
            // Because it will decrement postorderIndex without building node
            let right = rootIndex < end ? makeTree(rootIndex+1, end) : nil
            let left = rootIndex > start ? makeTree(start, rootIndex-1) : nil

            return TreeNode(value, left, right)
        }
        
        return makeTree(0, postorder.count-1)
    }
}