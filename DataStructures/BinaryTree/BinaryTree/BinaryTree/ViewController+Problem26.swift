//
//  ViewController+Problem26.swift
//  BinaryTree
//
//  Created by Manish Rathi on 15/03/2022.
//

import Foundation
/*
 110. Balanced Binary Tree
 https://leetcode.com/problems/balanced-binary-tree/
 Given a binary tree, determine if it is height-balanced.

 For this problem, a height-balanced binary tree is defined as:
 a binary tree in which the left and right subtrees of every node differ in height by no more than 1.

 Example 1:
 Input: root = [3,9,20,null,null,15,7]
 Output: true

 Example 2:
 Input: root = [1,2,2,3,3,null,null,4,4]
 Output: false

 Example 3:
 Input: root = []
 Output: true
 */

extension ViewController {
    func solve26() {
        print("Setting up Problem26 input!")
        let root = TreeNode(1)
        root.left = TreeNode(0)
        root.right = TreeNode(1)
        root.left?.left = TreeNode(0)
        root.left?.right = TreeNode(0)
        root.right?.left = TreeNode(1)
        root.right?.right = TreeNode(1)
        root.left?.left?.left = TreeNode(0)

        let output = Solution().isBalanced(root)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    func isBalanced(_ root: TreeNode?) -> Bool {
        guard let currentNode = root else { return true }

        let leftHeight = height(currentNode.left)
        let rightHeight = height(currentNode.right)

        if abs(leftHeight - rightHeight) > 1 { return false }

        return isBalanced(currentNode.left) && isBalanced(currentNode.right)
    }

    private func height(_ root: TreeNode?) -> Int {
        guard let currentNode = root else { return 0 }

        let leftHeight = height(currentNode.left)
        let rightHeight = height(currentNode.right)

        return 1 + max(leftHeight, rightHeight)
    }
}
