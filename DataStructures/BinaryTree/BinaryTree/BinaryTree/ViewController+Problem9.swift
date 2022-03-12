//
//  ViewController+Problem9.swift
//  BinaryTree
//
//  Created by Manish Rathi on 12/03/2022.
//

import Foundation
/*
 108. Convert Sorted Array to Binary Search Tree
 https://leetcode.com/problems/convert-sorted-array-to-binary-search-tree/

 Given an integer array nums where the elements are sorted in ascending order, convert it to a height-balanced binary search tree.
 A height-balanced binary tree is a binary tree in which the depth of the two subtrees of every node never differs by more than one.

 Example 1:
 Input: nums = [-10,-3,0,5,9]
 Output: [0,-3,9,-10,null,5]
 Explanation: [0,-10,5,null,-3,null,9] is also accepted:

 Example 2:
 Input: nums = [1,3]
 Output: [3,1]
 Explanation: [1,null,3] and [3,1] are both height-balanced BSTs.
 */

extension ViewController {
    func solve9() {
        print("Setting up Problem9 input!")
        let input = [5, 10, 15, 20]

        let output = Solution().sortedArrayToBST(input)
        print("Output: \(String(describing: output?.inorderTraversal))")
    }
}

fileprivate class Solution {
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
