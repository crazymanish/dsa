//
//  ViewController+Problem56.swift
//  BinaryTree
//
//  Created by Manish Rathi on 19/03/2022.
//

import Foundation
/*
 98. Validate Binary Search Tree
 https://leetcode.com/problems/validate-binary-search-tree/
 Given the root of a binary tree, determine if it is a valid binary search tree (BST).
 A valid BST is defined as follows:
 The left subtree of a node contains only nodes with keys less than the node's key.
 The right subtree of a node contains only nodes with keys greater than the node's key.
 Both the left and right subtrees must also be binary search trees.

 Example 1:
 Input: root = [2,1,3]
 Output: true

 Example 2:
 Input: root = [5,1,4,null,null,3,6]
 Output: false
 Explanation: The root node's value is 5 but its right child's value is 4.
 */

extension ViewController {
    func solve56() {
        print("Setting up Problem56 input!")
        let root1 = TreeNode(2)
        root1.left = TreeNode(1)
        root1.right = TreeNode(3)

        let root2 = TreeNode(5)
        root2.left = TreeNode(1)
        root2.right = TreeNode(4)
        root2.right?.left = TreeNode(3)
        root2.right?.right = TreeNode(6)

        var output = Solution().isValidBST(root1)
        print("Output1: \(output)")

        output = Solution().isValidBST(root2)
        print("Output2: \(output)")
    }
}

fileprivate class Solution {
    func isValidBST(_ root: TreeNode?) -> Bool {
        guard let currentNode = root else { return false }

        return findValidBST(currentNode)
    }

    private func findValidBST(_ root: TreeNode?, _ minLeft: Int = Int.min, _ maxRight: Int = Int.max) -> Bool {
        guard let currentNode = root else { return true }

        let currentNodeValue = currentNode.val

        let isLeftValidBST = findValidBST(currentNode.left, minLeft, currentNodeValue)
        let isRightValidBST = findValidBST(currentNode.right, currentNodeValue, maxRight)

        let isCurrentBST = minLeft < currentNodeValue && currentNodeValue < maxRight

        return isCurrentBST && isLeftValidBST && isRightValidBST
    }
}
