// https://leetcode.com/problems/maximum-binary-tree

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
    private var root: TreeNode? = nil

    func constructMaximumBinaryTree(_ nums: [Int]) -> TreeNode? {
        if nums.isEmpty { return nil }

        constructMaximumBinaryTree(nums, 0, nums.count-1)

        return root
    }

    @discardableResult
    private func constructMaximumBinaryTree(_ nums: [Int], _ leftIndex: Int, _ rightIndex: Int) -> TreeNode? {
        if leftIndex > rightIndex { return nil }

        let maximumValueIndex = findMaximumIndex(nums, leftIndex, rightIndex)

        let maximumValueNode = TreeNode(nums[maximumValueIndex])
        if root == nil { root = maximumValueNode }

        maximumValueNode.left = constructMaximumBinaryTree(nums, leftIndex, maximumValueIndex-1)
        maximumValueNode.right = constructMaximumBinaryTree(nums, maximumValueIndex+1, rightIndex)

        return maximumValueNode
    }

    private func findMaximumIndex(_ nums: [Int], _ leftIndex: Int, _ rightIndex: Int) -> Int {
        var maximumValueIndex = leftIndex

        for currentIndex in leftIndex...rightIndex {
            if nums[currentIndex] > nums[maximumValueIndex] {
                maximumValueIndex = currentIndex
            }
        }

        return maximumValueIndex
    }
}
