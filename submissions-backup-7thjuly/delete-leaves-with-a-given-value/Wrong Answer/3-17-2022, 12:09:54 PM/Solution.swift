// https://leetcode.com/problems/delete-leaves-with-a-given-value

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
    private var canRemoveMoreLeafNodes = true
    
    func removeLeafNodes(_ root: TreeNode?, _ target: Int) -> TreeNode? {
        guard let root = root else { return nil }
        
        while canRemoveMoreLeafNodes { 
            canRemoveMoreLeafNodes = deleteLeafNodes(root, target) 
        } 
        
        return root.val == target ? nil : root
    }
    
    private func deleteLeafNodes(_ root: TreeNode?, _ target: Int) -> Bool {
        guard let currentNode = root else { return false }
        
        let isCurrentNodeLeafDeleted = currentNode.deleteLeafNodeIfPossible(target)
        
        let isLeftLeafDeleted = deleteLeafNodes(currentNode.left, target)
        let isRightLeafDeleted = deleteLeafNodes(currentNode.right, target)
        
        return isCurrentNodeLeafDeleted || isLeftLeafDeleted || isRightLeafDeleted
    }
}

extension TreeNode {
    var isLeafNode: Bool {
        return left == nil && right == nil
    }
    
    func deleteLeafNodeIfPossible(_ target: Int) -> Bool {
        var isDeletedLeafNode = false
        
        if let leftChild = left, leftChild.val == target, leftChild.isLeafNode {
            left = nil
            isDeletedLeafNode = true
        }
        
        if let rightChild = right, rightChild.val == target, rightChild.isLeafNode {
            right = nil
            isDeletedLeafNode = true
        }
        
        return isDeletedLeafNode
    }
}