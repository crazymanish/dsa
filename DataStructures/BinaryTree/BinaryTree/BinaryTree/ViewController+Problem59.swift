//
//  ViewController+Problem59.swift
//  BinaryTree
//
//  Created by Manish Rathi on 19/03/2022.
//

import Foundation
/*
 538. Convert BST to Greater Tree
 https://leetcode.com/problems/convert-bst-to-greater-tree/
 Given the root of a Binary Search Tree (BST), convert it to a Greater Tree such that every key of the original BST is changed to the original key plus the sum of all keys greater than the original key in BST.

 As a reminder, a binary search tree is a tree that satisfies these constraints:
 The left subtree of a node contains only nodes with keys less than the node's key.
 The right subtree of a node contains only nodes with keys greater than the node's key.
 Both the left and right subtrees must also be binary search trees.

 Example 1:
 Input: root = [4,1,6,0,2,5,7,null,null,null,3,null,null,null,8]
 Output: [30,36,21,36,35,26,15,null,null,null,33,null,null,null,8]

 Example 2:
 Input: root = [0,null,1]
 Output: [1,null,1]
 */

extension ViewController {
    func solve59() {
        print("Setting up Problem59 input!")
        let root = TreeNode(0)
        root.right = TreeNode(1)

        print("Input: \(root.inorderTraversal)")
        let output = Solution().convertBST(root)
        print("Output: \(output!.inorderTraversal)")
    }
}

fileprivate class Solution {
    private var tempValue = 0

    func convertBST(_ root: TreeNode?) -> TreeNode? {
        convertBstToGst(root)

        return root
    }

    private func convertBstToGst(_ root: TreeNode?) {
        guard let currentNode = root else { return }

        convertBstToGst(currentNode.right)

        tempValue += currentNode.val
        currentNode.val = tempValue

        convertBstToGst(currentNode.left)
    }
}
