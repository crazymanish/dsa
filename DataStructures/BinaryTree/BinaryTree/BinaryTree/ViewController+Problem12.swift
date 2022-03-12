//
//  ViewController+Problem12.swift
//  BinaryTree
//
//  Created by Manish Rathi on 12/03/2022.
//

import Foundation
/*
 144. Binary Tree Preorder Traversal
 https://leetcode.com/problems/binary-tree-preorder-traversal/
 Given the root of a binary tree, return the preorder traversal of its nodes' values.

 Example 1:
 Input: root = [1,null,2,3]
 Output: [1,2,3]

 Example 2:
 Input: root = []
 Output: []

 Example 3:
 Input: root = [1]
 Output: [1]
 */

extension ViewController {
    func solve12() {
        print("Setting up Problem12 input!")
        let root = TreeNode(1)
        root.right = TreeNode(2)
        root.right?.left = TreeNode(3)

        let output = Solution().preorderTraversal(root)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    func preorderTraversal(_ root: TreeNode?) -> [Int] {
        guard let rootNode = root else { return [] }

        let leftPreorderTraversal = preorderTraversal(rootNode.left)
        let rightPreorderTraversal = preorderTraversal(rootNode.right)

        return [rootNode.val] + leftPreorderTraversal + rightPreorderTraversal
    }
}
