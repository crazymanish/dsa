//
//  ViewController+Problem29.swift
//  BinaryTree
//
//  Created by Manish Rathi on 16/03/2022.
//

import Foundation
/*
 671. Second Minimum Node In a Binary Tree
 https://leetcode.com/problems/second-minimum-node-in-a-binary-tree/
 Given a non-empty special binary tree consisting of nodes with the non-negative value, where each node in this tree has exactly two or zero sub-node. If the node has two sub-nodes, then this node's value is the smaller value among its two sub-nodes. More formally, the property root.val = min(root.left.val, root.right.val) always holds.

 Given such a binary tree, you need to output the second minimum value in the set made of all the nodes' value in the whole tree.
 If no such second minimum value exists, output -1 instead.

 Example 1:
 Input: root = [2,2,5,null,null,5,7]
 Output: 5
 Explanation: The smallest value is 2, the second smallest value is 5.

 Example 2:
 Input: root = [2,2,2]
 Output: -1
 Explanation: The smallest value is 2, but there isn't any second smallest value.
 */

extension ViewController {
    func solve29() {
        print("Setting up Problem29 input!")
        let root = TreeNode(2)
        root.left = TreeNode(2)
        root.right = TreeNode(5)
        root.right?.left = TreeNode(5)
        root.right?.right = TreeNode(7)

        let output = Solution().findSecondMinimumValue(root)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    private var secondMinimumValue = Int.max

    func findSecondMinimumValue(_ root: TreeNode?) -> Int {
        guard let root = root else { return -1 }

        findMinimumValue(root.left, root.val)
        findMinimumValue(root.right, root.val)

        if secondMinimumValue == Int.max { return -1 } // No second minimum value found

        return secondMinimumValue
    }

    private func findMinimumValue(_ root: TreeNode?, _ firstMinimumValue: Int) {
        guard let currentNode = root else { return }

        if currentNode.val > firstMinimumValue {
            secondMinimumValue = min(secondMinimumValue, currentNode.val)
        }

        findMinimumValue(currentNode.left, firstMinimumValue)
        findMinimumValue(currentNode.right, firstMinimumValue)
    }
}
