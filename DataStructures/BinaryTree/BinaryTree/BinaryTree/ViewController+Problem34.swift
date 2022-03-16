//
//  ViewController+Problem34.swift
//  BinaryTree
//
//  Created by Manish Rathi on 16/03/2022.
//

import Foundation
/*
 654. Maximum Binary Tree
 https://leetcode.com/problems/maximum-binary-tree/
 You are given an integer array nums with no duplicates. A maximum binary tree can be built recursively from nums using the following algorithm:

 Create a root node whose value is the maximum value in nums.
 Recursively build the left subtree on the subarray prefix to the left of the maximum value.
 Recursively build the right subtree on the subarray suffix to the right of the maximum value.
 Return the maximum binary tree built from nums.

 Example 1:
 Input: nums = [3,2,1,6,0,5]
 Output: [6,3,5,null,2,0,null,null,1]
 Explanation: The recursive calls are as follow:
 - The largest value in [3,2,1,6,0,5] is 6. Left prefix is [3,2,1] and right suffix is [0,5].
     - The largest value in [3,2,1] is 3. Left prefix is [] and right suffix is [2,1].
         - Empty array, so no child.
         - The largest value in [2,1] is 2. Left prefix is [] and right suffix is [1].
             - Empty array, so no child.
             - Only one element, so child is a node with value 1.
     - The largest value in [0,5] is 5. Left prefix is [0] and right suffix is [].
         - Only one element, so child is a node with value 0.
         - Empty array, so no child.

 Example 2:
 Input: nums = [3,2,1]
 Output: [3,null,2,null,1]
 */

extension ViewController {
    func solve34() {
        print("Setting up Problem34 input!")

        let nums = [3,2,1,6,0,5]
        let output = Solution().constructMaximumBinaryTree(nums)
        print("Output: \(output!.inorderTraversal)")
    }
}

fileprivate class Solution {
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
