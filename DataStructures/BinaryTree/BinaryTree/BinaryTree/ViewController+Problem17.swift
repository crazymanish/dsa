//
//  ViewController+Problem17.swift
//  BinaryTree
//
//  Created by Manish Rathi on 13/03/2022.
//

import Foundation
/*
 235. Lowest Common Ancestor of a Binary Search Tree
 https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-search-tree/
 Given a binary search tree (BST), find the lowest common ancestor (LCA) of two given nodes in the BST.
 According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between two nodes p and q as the lowest node in T that has both p and q as descendants (where we allow a node to be a descendant of itself).”

 Example 1:
 Input: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 8
 Output: 6
 Explanation: The LCA of nodes 2 and 8 is 6.

 Example 2:
 Input: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 4
 Output: 2
 Explanation: The LCA of nodes 2 and 4 is 2, since a node can be a descendant of itself according to the LCA definition.

 Example 3:
 Input: root = [2,1], p = 2, q = 1
 Output: 2
 */

extension ViewController {
    func solve17() {
        print("Setting up Problem17 input!")
        
        let root = TreeNode(6)
        root.left = TreeNode(2)
        root.right = TreeNode(8)
        root.left?.left = TreeNode(0)
        root.left?.right = TreeNode(4)
        root.left?.right?.left = TreeNode(3)
        root.left?.right?.right = TreeNode(5)
        root.right?.left = TreeNode(7)
        root.right?.right = TreeNode(9)

        let output = Solution().lowestCommonAncestor(root, root.left, root.right)
        print("Output: \(output!.val)")
    }
}

fileprivate class Solution {
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        guard let root = root, let p = p, let q = q else { return nil }

        if root.val > p.val && root.val > q.val {
            return lowestCommonAncestor(root.left, p, q)
        } else if root.val < p.val && root.val < q.val {
            return lowestCommonAncestor(root.right, p, q)
        } else {
            return root
        }
    }
}
