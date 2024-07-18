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
    func countPairs(_ root: TreeNode?, _ distance: Int) -> Int {
        var result = 0
        
        // O(n^2) time, O(n) space, n is num of leafs
        func postOrder(_ root: TreeNode?, _ distance: Int) -> [Int] {
            // Base case
            guard let root = root else { return [] }
        
            if root.left == nil && root.right == nil { return [1] }

            // Recursive case
            let leftLeafs = postOrder(root.left, distance)
            let rightLeafs = postOrder(root.right, distance)

            for left in leftLeafs {
                for right in rightLeafs {
                    if left + right <= distance {
                        result += 1
                    }
                }
            }

            return (leftLeafs + rightLeafs).map { $0 + 1 }
        }
        
        postOrder(root, distance)
        return result
    }
}