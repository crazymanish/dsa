//
//  ViewController+Problem23.swift
//  BinaryTree
//
//  Created by Manish Rathi on 15/03/2022.
//

import Foundation
/*
 543. Diameter of Binary Tree
 https://leetcode.com/problems/diameter-of-binary-tree/
 Given the root of a binary tree, return the length of the diameter of the tree.
 The diameter of a binary tree is the length of the longest path between any two nodes in a tree. This path may or may not pass through the root.
 The length of a path between two nodes is represented by the number of edges between them.

 Example 1:
 Input: root = [1,2,3,4,5]
 Output: 3
 Explanation: 3 is the length of the path [4,2,1,3] or [5,2,1,3].

 Example 2:
 Input: root = [1,2]
 Output: 1
 */

extension ViewController {
    func solve23() {
        print("Setting up Problem23 input!")
        let root = TreeNode(1)
        root.left = TreeNode(2)
        root.right = TreeNode(3)
        root.left?.right = TreeNode(4)
        root.left?.right = TreeNode(5)

        let output = Solution().diameterOfBinaryTree(root)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    private var outputDiameter: Int = Int.min

    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        calculateDiameterOfBinaryTree(root)

        return outputDiameter - 1 // length
    }

    @discardableResult
    private func calculateDiameterOfBinaryTree(_ root: TreeNode?) -> Int {
        guard let currentNode = root else { return 0 }

        let leftDiameter = calculateDiameterOfBinaryTree(currentNode.left)
        let rightDiameter = calculateDiameterOfBinaryTree(currentNode.right)

        let currentNodeDiameter = max(leftDiameter, rightDiameter) + 1
        let possibleDiameter = max(currentNodeDiameter, 1 + leftDiameter + rightDiameter)

        outputDiameter = max(outputDiameter, possibleDiameter)

        return currentNodeDiameter
    }
}
