//
//  ViewController+Problem5.swift
//  BinaryTree
//
//  Created by Manish Rathi on 10/03/2022.
//

import Foundation
/*
 226. Invert Binary Tree
 https://leetcode.com/problems/invert-binary-tree/
 Given the root of a binary tree, invert the tree, and return its root.

 Example 1:
 Input: root = [4,2,7,1,3,6,9]
 Output: [4,7,2,9,6,3,1]

 Example 2:
 Input: root = [2,1,3]
 Output: [2,3,1]
 */

extension ViewController {
    func solve5() {
        print("Setting up Problem5 input!")
        let root = TreeNode(4)
        root.left = TreeNode(2)
        root.right = TreeNode(7)
        root.left?.left = TreeNode(1)
        root.left?.right = TreeNode(3)
        root.right?.left = TreeNode(6)
        root.right?.right = TreeNode(9)

        let output = Solution().invertTree(root)
        print("Output: \(output as Any)")
    }
}

fileprivate class Solution {
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        if root == nil { return nil }

        let leftInvertTree = invertTree(root?.left)
        let rightInvertTree = invertTree(root?.right)

        return TreeNode(root!.val, rightInvertTree, leftInvertTree)
    }
}
