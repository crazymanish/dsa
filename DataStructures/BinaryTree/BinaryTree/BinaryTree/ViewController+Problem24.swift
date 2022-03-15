//
//  ViewController+Problem24.swift
//  BinaryTree
//
//  Created by Manish Rathi on 15/03/2022.
//

import Foundation
/*
 101. Symmetric Tree
 https://leetcode.com/problems/symmetric-tree/
 Given the root of a binary tree, check whether it is a mirror of itself (i.e., symmetric around its center).

 Example 1:
 Input: root = [1,2,2,3,4,4,3]
 Output: true

 Example 2:
 Input: root = [1,2,2,null,3,null,3]
 Output: false
 */

extension ViewController {
    func solve24() {
        print("Setting up Problem24 input!")
        let root = TreeNode(1)
        root.left = TreeNode(2)
        root.right = TreeNode(2)
        root.left?.left = TreeNode(3)
        root.left?.right = TreeNode(4)
        root.right?.left = TreeNode(4)
        root.right?.right = TreeNode(3)

        let output = Solution().isSymmetric(root)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    func isSymmetric(_ root: TreeNode?) -> Bool {
        guard let currentNode = root else { return false }

        let leftFirstTraversal = leftFirstTraversal(currentNode.left)
        let rightFirstTraversal = rightFirstTraversal(currentNode.right)

        return leftFirstTraversal == rightFirstTraversal
    }

    private func leftFirstTraversal(_ root: TreeNode?) -> String {
        guard let currentNode = root else { return "0" }

        let left = leftFirstTraversal(currentNode.left)
        let right = leftFirstTraversal(currentNode.right)

        return "\(currentNode.val)" + left + right
    }

    private func rightFirstTraversal(_ root: TreeNode?) -> String {
        guard let currentNode = root else { return "0" }

        let left = rightFirstTraversal(currentNode.left)
        let right = rightFirstTraversal(currentNode.right)

        return "\(currentNode.val)" + right + left
    }
}
