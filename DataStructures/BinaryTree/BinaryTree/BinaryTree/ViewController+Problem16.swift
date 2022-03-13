//
//  ViewController+Problem16.swift
//  BinaryTree
//
//  Created by Manish Rathi on 13/03/2022.
//

import Foundation
/*
 606. Construct String from Binary Tree
 https://leetcode.com/problems/construct-string-from-binary-tree/
 Given the root of a binary tree, construct a string consisting of parenthesis and integers from a binary tree with the preorder traversal way, and return it.
 Omit all the empty parenthesis pairs that do not affect the one-to-one mapping relationship between the string and the original binary tree.

 Example 1:
 Input: root = [1,2,3,4]
 Output: "1(2(4))(3)"
 Explanation: Originally, it needs to be "1(2(4)())(3()())", but you need to omit all the unnecessary empty parenthesis pairs. And it will be "1(2(4))(3)"

 Example 2:
 Input: root = [1,2,3,null,4]
 Output: "1(2()(4))(3)"
 Explanation: Almost the same as the first example, except we cannot omit the first parenthesis pair to break the one-to-one mapping relationship between the input and the output.
 */

extension ViewController {
    func solve16() {
        print("Setting up Problem16 input!")
        let root = TreeNode(1)
        root.left = TreeNode(2)
        root.right = TreeNode(3)
        root.left?.right = TreeNode(4)

        let output = Solution().tree2str(root)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    func tree2str(_ root: TreeNode?) -> String {
        guard let root = root else { return "" }

        if root.left == nil && root.right == nil {
            return "\(root.val)"
        }

        let leftTree2str = tree2str(root.left)

        if root.left != nil && root.right == nil {
            return "\(root.val)" + "(" + leftTree2str + ")"
        }

        let rightTree2str = tree2str(root.right)

        return "\(root.val)" + "(" + leftTree2str + ")"  + "(" + rightTree2str + ")"
    }
}
