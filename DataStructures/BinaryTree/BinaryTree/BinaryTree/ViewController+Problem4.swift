//
//  ViewController+Problem4.swift
//  BinaryTree
//
//  Created by Manish Rathi on 09/03/2022.
//

import Foundation
/*
 104. Maximum Depth of Binary Tree
 https://leetcode.com/problems/maximum-depth-of-binary-tree/

 Given the root of a binary tree, return its maximum depth.
 A binary tree's maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.

 Example 1:

 Input: root = [3,9,20,null,null,15,7]
 Output: 3
 Example 2:

 Input: root = [1,null,2]
 Output: 2
 */

extension ViewController {
    func solve4() {
        print("Setting up Problem4 input!")
        let root = TreeNode(3)
        root.left = TreeNode(9)
        root.right = TreeNode(20)
        root.right?.left = TreeNode(15)
        root.right?.right = TreeNode(7)

        let output = Solution().maxDepth(root)
        print("Output: \(output as Any)")
    }
}

fileprivate class Solution {
    var maxDepth = 0

    func maxDepth(_ root: TreeNode?) -> Int {
        findMaxDepth(root, 0)

        return maxDepth
    }

    private func findMaxDepth(_ root: TreeNode?, _ currentDepth: Int) {
        if root == nil { return }

        let newCurrentDepth = currentDepth + 1

        if root?.left == nil && root?.right == nil {
            maxDepth = max(maxDepth, newCurrentDepth)
        } else {
            findMaxDepth(root?.left, newCurrentDepth)
            findMaxDepth(root?.right, newCurrentDepth)
        }
    }
}
