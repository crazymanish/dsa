//
//  ViewController+Problem46.swift
//  BinaryTree
//
//  Created by Manish Rathi on 18/03/2022.
//

import Foundation
/*
 230. Kth Smallest Element in a BST
 https://leetcode.com/problems/kth-smallest-element-in-a-bst/
 Given the root of a binary search tree, and an integer k, return the kth smallest value (1-indexed) of all the values of the nodes in the tree.

 Example 1:
 Input: root = [3,1,4,null,2], k = 1
 Output: 1

 Example 2:
 Input: root = [5,3,6,2,4,null,null,1], k = 3
 Output: 3
 */

extension ViewController {
    func solve46() {
        print("Setting up Problem46 input!")
        let root = TreeNode(3)
        root.left = TreeNode(1)
        root.right = TreeNode(4)
        root.left?.right = TreeNode(2)

        let output = Solution().kthSmallest(root, 1)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
        guard let root = root else { return 0 }

        let allElements = inorderTraversal(root)

        return allElements[k-1]
    }

    private func inorderTraversal(_ root: TreeNode?) -> [Int] {
        guard let currentNode = root else { return [] }

        let leftInorderTraversal = inorderTraversal(currentNode.left)
        let rightInorderTraversal = inorderTraversal(currentNode.right)

        return leftInorderTraversal + [currentNode.val] + rightInorderTraversal
    }
}
