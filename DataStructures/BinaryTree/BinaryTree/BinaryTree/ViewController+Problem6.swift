//
//  ViewController+Problem6.swift
//  BinaryTree
//
//  Created by Manish Rathi on 10/03/2022.
//

import Foundation
/*
 94. Binary Tree Inorder Traversal
 https://leetcode.com/problems/binary-tree-inorder-traversal/
 Given the root of a binary tree, return the inorder traversal of its nodes' values.

 Example 1:
 Input: root = [1,null,2,3]
 Output: [1,3,2]

 Example 2:
 Input: root = []
 Output: []

 Example 3:
 Input: root = [1]
 Output: [1]
 */

extension ViewController {
    func solve6() {
        print("Setting up Problem6 input!")
        let root = TreeNode(1)
        root.right = TreeNode(2)
        root.right?.left = TreeNode(3)

        let output = Solution().inorderTraversal(root)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        if root == nil { return [] }

        let leftInorderTraversal = inorderTraversal(root?.left)
        let rightInorderTraversal = inorderTraversal(root?.right)

        return leftInorderTraversal + [root!.val] + rightInorderTraversal
    }
}
