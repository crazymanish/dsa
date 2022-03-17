//
//  ViewController+Problem35.swift
//  BinaryTree
//
//  Created by Manish Rathi on 17/03/2022.
//

import Foundation
/*
 701. Insert into a Binary Search Tree
 https://leetcode.com/problems/insert-into-a-binary-search-tree/
 You are given the root node of a binary search tree (BST) and a value to insert into the tree. Return the root node of the BST after the insertion. It is guaranteed that the new value does not exist in the original BST.
 Notice that there may exist multiple valid ways for the insertion, as long as the tree remains a BST after insertion. You can return any of them.

 Example 1:
 Input: root = [4,2,7,1,3], val = 5
 Output: [4,2,7,1,3,5]
 Explanation: Another accepted tree is:

 Example 2:
 Input: root = [40,20,60,10,30,50,70], val = 25
 Output: [40,20,60,10,30,50,70,null,null,25]

 Example 3:
 Input: root = [4,2,7,1,3,null,null,null,null,null,null], val = 5
 Output: [4,2,7,1,3,5]
 */

extension ViewController {
    func solve35() {
        print("Setting up Problem35 input!")
        let root = TreeNode(4)
        root.left = TreeNode(2)
        root.right = TreeNode(7)
        root.left?.left = TreeNode(1)
        root.left?.right = TreeNode(3)

        print("Input: \(root.inorderTraversal)")

        let output = Solution().insertIntoBST(root, 5)
        print("Output: \(output!.inorderTraversal)")
    }
}

fileprivate class Solution {
    private var rootNode: TreeNode? = nil

    func insertIntoBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        guard let root = root else { return TreeNode(val) }

        rootNode = root
        insert(rootNode, val)

        return rootNode
    }

    @discardableResult
    private func insert(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        guard let currentNode = root else { return TreeNode(val) }

        if currentNode.val < val {
            if currentNode.right == nil {
                currentNode.right = insert(currentNode.right, val)
            } else {
                return insert(currentNode.right, val)
            }
        } else {
            if currentNode.left == nil {
                currentNode.left = insert(currentNode.left, val)
            } else {
                return insert(currentNode.left, val)
            }
        }

        return currentNode
    }
}
