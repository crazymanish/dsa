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
    func maxProduct(_ root: TreeNode?) -> Int {
        var subtreeSums: [Int] = []

        func calculateSum(root: TreeNode?) -> Int {
            guard let node = root else { return 0 }
            let sum = node.val + calculateSum(root: node.left) + calculateSum(root: node.right)
            subtreeSums.append(sum)
            return sum
        }

        let totalSum = calculateSum(root: root)
        var answer = 0
        for subtreeSum in subtreeSums {
            answer = max(
                answer,
                subtreeSum * (totalSum - subtreeSum)
            )
        }
        
        return answer % Int(1E9+7)
    }
}