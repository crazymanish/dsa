//
//  ViewController+Problem2.swift
//  BinaryTree
//
//  Created by Manish Rathi on 08/03/2022.
//

import Foundation
/*
 700. Search in a Binary Search Tree
 https://leetcode.com/problems/search-in-a-binary-search-tree/

 You are given the root of a binary search tree (BST) and an integer val.

 Find the node in the BST that the node's value equals val and return the subtree rooted with that node. If such a node does not exist, return null.
 */

extension ViewController {
    func solve2() {
        print("Setting up Problem2 input!")
        let root = TreeNode(5)
        root.left = TreeNode(1)
        root.right = TreeNode(7)

        let output = searchBST(root, 1)
        print("Output: \(output as Any)")
    }

    func searchBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        if root == nil { return nil }

        if root!.val == val { return root }

        if root!.val < val {
            return searchBST(root?.right, val)
        } else {
            return searchBST(root?.left, val)
        }
    }
}
