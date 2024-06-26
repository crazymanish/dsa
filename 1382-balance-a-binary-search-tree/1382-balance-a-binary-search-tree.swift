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
    func balanceBST(_ root: TreeNode?) -> TreeNode? {
        var sortedNodes = [TreeNode]()
        
        func inorder(_ node: TreeNode?) {
            guard let node = node else { return }
            
            inorder(node.left)
            sortedNodes.append(node)
            inorder(node.right)
        }
        
        func build(_ nodes: [TreeNode], _ start: Int, _ end: Int) -> TreeNode? {
            if start > end { return nil }
  
            let mid = (start+end) / 2
            var node = nodes[mid] 
            
            node.left = build(nodes, start, mid-1)
            node.right = build(nodes, mid+1, end)

            return node
        }
        
        inorder(root)
        return build(sortedNodes, 0, sortedNodes.count-1)
    }
}