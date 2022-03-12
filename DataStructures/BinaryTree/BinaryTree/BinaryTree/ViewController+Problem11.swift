//
//  ViewController+Problem11.swift
//  BinaryTree
//
//  Created by Manish Rathi on 12/03/2022.
//

import Foundation
/*
 145. Binary Tree Postorder Traversal
 https://leetcode.com/problems/binary-tree-postorder-traversal/
 Given the root of a binary tree, return the postorder traversal of its nodes' values.

 Example 1:
 Input: root = [1,null,2,3]
 Output: [3,2,1]

 Example 2:
 Input: root = []
 Output: []

 Example 3:
 Input: root = [1]
 Output: [1]
 */

extension ViewController {
    func solve11() {
        print("Setting up Problem11 input!")
        let root = TreeNode(1)
        root.right = TreeNode(2)
        root.right?.left = TreeNode(3)

        let output = Solution().postorderTraversal(root)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    func postorderTraversal(_ root: TreeNode?) -> [Int] {
        guard let rootNode = root else { return [] }

        let leftPostorderTraversal = postorderTraversal(rootNode.left)
        let rightPostorderTraversal = postorderTraversal(rootNode.right)

        return leftPostorderTraversal + rightPostorderTraversal + [rootNode.val]
    }
}
