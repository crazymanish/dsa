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
    func pseudoPalindromicPaths (_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        
        var path = Array(repeating: 0, count: 10) //Constraints: 1 <= Node.val <= 9
        var result = 0
        
        func helper(_ node: TreeNode) {
            path[node.val] += 1
            
            if node.left == nil && node.right == nil { // leaf
                if path.reduce(into: Int(0), { if $1 % 2 == 1 { $0 += 1 } }) < 2 { result += 1 }
            } else { // not leaf
                if let left = node.left { helper(left) }
                if let right = node.right { helper(right) }
            }
            
            path[node.val] -= 1
        }
        
        helper(root)
        return result
    }
}