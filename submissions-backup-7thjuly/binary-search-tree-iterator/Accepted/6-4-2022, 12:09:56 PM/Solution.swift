// https://leetcode.com/problems/binary-search-tree-iterator

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

class BSTIterator {
    private var array: [Int] = []

    init(_ root: TreeNode?) {
        array = inorderTraversal(root)
    }
    
    private func inorderTraversal(_ root: TreeNode?) -> [Int] {
        guard let currentNode = root else { return [] }
        
        let leftInorderTraversal = inorderTraversal(currentNode.left)
        let rightInorderTraversal = inorderTraversal(currentNode.right)
        
        return leftInorderTraversal + [currentNode.val] + rightInorderTraversal
    }
    
    func next() -> Int { array.removeFirst() }
    
    func hasNext() -> Bool { !array.isEmpty }
}

/**
 * Your BSTIterator object will be instantiated and called as such:
 * let obj = BSTIterator(root)
 * let ret_1: Int = obj.next()
 * let ret_2: Bool = obj.hasNext()
 */