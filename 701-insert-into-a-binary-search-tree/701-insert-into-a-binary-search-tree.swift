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
    private var rootNode: TreeNode? = nil
    
    func insertIntoBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        guard let root = root else { return TreeNode(val) }
        
        rootNode = root
        insert(rootNode, val)
        
        return rootNode
    }
    
    private func insert(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        guard let currentNode = root else { return TreeNode(val) }
        
        if currentNode.val < val {
            if currentNode.right == nil {
                currentNode.right = insert(currentNode.right, val)
            } else {
                return insert(currentNode.right, val)   
            }
        } else {
            if currentNode.left == nil {
                currentNode.left = insert(currentNode.left, val)  
            } else {
                return insert(currentNode.left, val)  
            }
        }
        
        return currentNode
    }
}