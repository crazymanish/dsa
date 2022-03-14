//
//  ViewController+Problem20.swift
//  BinaryTree
//
//  Created by Manish Rathi on 14/03/2022.
//

import Foundation
/*
 100. Same Tree
 https://leetcode.com/problems/same-tree/
 Given the roots of two binary trees p and q, write a function to check if they are the same or not.
 Two binary trees are considered the same if they are structurally identical, and the nodes have the same value.

 Example 1:
 Input: p = [1,2,3], q = [1,2,3]
 Output: true

 Example 2:
 Input: p = [1,2], q = [1,null,2]
 Output: false

 Example 3:
 Input: p = [1,2,1], q = [1,1,2]
 Output: false
 */

extension ViewController {
    func solve20() {
        print("Setting up Problem20 input!")
        let root1 = TreeNode(1)
        root1.left = TreeNode(2)
        root1.right = TreeNode(3)

        let root2 = TreeNode(1)
        root2.left = TreeNode(2)
        root2.right = TreeNode(3)

        let output = Solution().isSameTree(root1, root2)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if p == nil, q == nil { return true }

        guard let p = p, let q = q else { return false }

        if p.val != q.val { return false }

        let isLeftSameTree = isSameTree(p.left, q.left)
        let isRightSameTree = isSameTree(p.right, q.right)

        return isLeftSameTree && isRightSameTree
    }
}
