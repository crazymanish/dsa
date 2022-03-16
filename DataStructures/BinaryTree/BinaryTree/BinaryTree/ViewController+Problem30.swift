//
//  ViewController+Problem30.swift
//  BinaryTree
//
//  Created by Manish Rathi on 16/03/2022.
//

import Foundation
/*
 111. Minimum Depth of Binary Tree
 https://leetcode.com/problems/minimum-depth-of-binary-tree/
 Given a binary tree, find its minimum depth.
 The minimum depth is the number of nodes along the shortest path from the root node down to the nearest leaf node.
 Note: A leaf is a node with no children.

 Example 1:
 Input: root = [3,9,20,null,null,15,7]
 Output: 2

 Example 2:
 Input: root = [2,null,3,null,4,null,5,null,6]
 Output: 5
 */

extension ViewController {
    func solve30() {
        print("Setting up Problem30 input!")
        let root = TreeNode(3)
        root.left = TreeNode(9)
        root.right = TreeNode(20)
        root.right?.left = TreeNode(15)
        root.right?.right = TreeNode(7)

        let output = Solution().minDepth(root)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    private var minDepth = Int.max

    func minDepth(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }

        findAllDepths(root, 0)

        return minDepth
    }

    private func findAllDepths(_ root: TreeNode?, _ currentDepth: Int) {
        guard let currentNode = root else { return }

        let newDepth = currentDepth + 1

        if currentNode.left == nil && currentNode.right == nil {
            minDepth = min(minDepth, newDepth)
        }

        findAllDepths(currentNode.left, newDepth)
        findAllDepths(currentNode.right, newDepth)
    }
}
