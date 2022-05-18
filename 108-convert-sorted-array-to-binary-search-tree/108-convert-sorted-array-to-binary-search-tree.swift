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
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        if nums.isEmpty { return nil }

        let mid = nums.count / 2

        let root = TreeNode(nums[mid])
        let left = sortedArrayToBST(Array(nums[0..<mid]))
        let right = sortedArrayToBST(Array(nums[mid+1..<nums.count]))

        root.left = left
        root.right = right

        return root
    }
}