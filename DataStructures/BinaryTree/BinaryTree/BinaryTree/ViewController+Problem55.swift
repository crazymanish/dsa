//
//  ViewController+Problem55.swift
//  BinaryTree
//
//  Created by Manish Rathi on 19/03/2022.
//

import Foundation
/*
 236. Lowest Common Ancestor of a Binary Tree
 https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-tree/
 Given a binary tree, find the lowest common ancestor (LCA) of two given nodes in the tree.
 According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between two nodes p and q as the lowest node in T that has both p and q as descendants (where we allow a node to be a descendant of itself).”

 Example 1:
 Input: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 1
 Output: 3
 Explanation: The LCA of nodes 5 and 1 is 3.

 Example 2:
 Input: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 4
 Output: 5
 Explanation: The LCA of nodes 5 and 4 is 5, since a node can be a descendant of itself according to the LCA definition.

 Example 3:
 Input: root = [1,2], p = 1, q = 2
 Output: 1
 */

extension ViewController {
    func solve55() {
        print("Setting up Problem55 input!")
        let root = TreeNode(3)
        root.left = TreeNode(5)
        root.right = TreeNode(1)
        root.left?.left = TreeNode(6)
        root.left?.right = TreeNode(2)
        root.right?.left = TreeNode(0)
        root.right?.right = TreeNode(8)
        root.left?.right?.left = TreeNode(7)
        root.left?.right?.right = TreeNode(4)

        let output = Solution().findLowestLCA(root, 5, 1)
        print("Output: \(output!.val)")
    }
}

fileprivate class Solution {
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        guard let root = root, let p = p, let q = q else { return nil }

        return findLowestLCA(root, p.val, q.val)
    }

    func findLowestLCA(_ root: TreeNode?, _ p: Int, _ q: Int) -> TreeNode? {
        guard let currentNode = root else { return nil }

        if currentNode.val == p || currentNode.val == q { return currentNode }

        let leftLowestLCA = findLowestLCA(currentNode.left, p, q)
        let rightLowestLCA = findLowestLCA(currentNode.right, p, q)

        if leftLowestLCA != nil && rightLowestLCA != nil { return currentNode }
        if leftLowestLCA != nil { return leftLowestLCA }
        if rightLowestLCA != nil { return rightLowestLCA }

        return nil
    }
}
