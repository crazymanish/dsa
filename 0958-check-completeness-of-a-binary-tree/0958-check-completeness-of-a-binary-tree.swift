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
    func isCompleteTree(_ root: TreeNode?) -> Bool {
        guard let node = root else { return true }
        
        var stack: [TreeNode?] = []
        stack.append(node)
        
        var foundEmpty = false
        
        while stack.count != 0 {
            if let currentNode = stack.removeFirst() {
                if foundEmpty { return false }
                
                stack.append(currentNode.left)
                stack.append(currentNode.right)
            } else {
                foundEmpty = true
            }
        }
        
        return true
    }
}