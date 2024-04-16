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
    func addOneRow(_ root: TreeNode?, _ v: Int, _ d: Int) -> TreeNode? {
        guard let root = root else { return nil }
        
        if d == 1 {
            let node = TreeNode(v)
            node.left = root
            return node
        }
        
        var queue = [root]
        
        for i in 0..<d-2 {
            let size = queue.count
            for j in 0..<size {
                let node = queue.removeFirst()
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
        }
        
        while !queue.isEmpty {
            let node = queue.removeFirst()
            var temp = node.left
            node.left = TreeNode(v)
            node.left!.left = temp
            
            temp = node.right
            node.right = TreeNode(v)
            node.right!.right = temp
        }
        
        return root
    }
}