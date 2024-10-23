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
    func replaceValueInTree(_ root: TreeNode?) -> TreeNode? {
        var bfsRow = [root].compactMap{$0}
        root?.val = 0 // root has no cousins
        
        while !bfsRow.isEmpty {
            let nodeChildrenSums = bfsRow.map{[$0.left,$0.right].compactMap{$0?.val ?? 0}.reduce(0,+)}
            let levelSum = nodeChildrenSums.reduce(0,+) 
            
            for (node, nodeChildrenSum) in zip(bfsRow, nodeChildrenSums) {
                let cousinsSum = levelSum - nodeChildrenSum 
                node.left?.val = cousinsSum
                node.right?.val = cousinsSum
            }
            
            bfsRow = bfsRow.flatMap{[$0.left, $0.right].compactMap{$0}} // move to next row in tree
        }
        
        return root
    }
}