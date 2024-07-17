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
    func delNodes(_ root: TreeNode?, _ to_delete: [Int]) -> [TreeNode?] {
        guard let root else { return [] }
        
        var set = Set(to_delete)
        var result = [TreeNode?]()
        
        if set.contains(root.val) == false {
            result.append(root)
        }
        
        func dfs(_ node: TreeNode?) -> TreeNode? {
            guard let node else { return nil }
           
            node.left = dfs(node.left)
            node.right = dfs(node.right)
            
            if set.contains(node.val) {
                if node.left != nil { result.append(node.left) }
                if node.right != nil { result.append(node.right) }
                return nil
            }
            
            return node
        }
        
        dfs(root)
        return result
    }
}