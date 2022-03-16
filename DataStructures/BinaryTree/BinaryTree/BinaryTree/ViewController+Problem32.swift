//
//  ViewController+Problem32.swift
//  BinaryTree
//
//  Created by Manish Rathi on 16/03/2022.
//

import Foundation
/*
 1315. Sum of Nodes with Even-Valued Grandparent
 https://leetcode.com/problems/sum-of-nodes-with-even-valued-grandparent/
 Given the root of a binary tree, return the sum of values of nodes with an even-valued grandparent. If there are no nodes with an even-valued grandparent, return 0.
 A grandparent of a node is the parent of its parent if it exists.

 Example 1:
 Input: root = [6,7,8,2,7,1,3,9,null,1,4,null,null,null,5]
 Output: 18
 Explanation: The red nodes are the nodes with even-value grandparent while the blue nodes are the even-value grandparents.

 Example 2:
 Input: root = [1]
 Output: 0
 */

extension ViewController {
    func solve32() {
        print("Setting up Problem32 input!")
        let root = TreeNode(6)
        root.left = TreeNode(7)
        root.right = TreeNode(8)
        root.left?.left = TreeNode(2)
        root.left?.right = TreeNode(7)
        root.right?.left = TreeNode(1)
        root.right?.right = TreeNode(3)
        root.left?.left?.left = TreeNode(9)
        root.left?.right?.left = TreeNode(1)
        root.left?.right?.right = TreeNode(4)
        root.right?.right?.right = TreeNode(5)

        let output = Solution().sumEvenGrandparent(root)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    private var grandparentNodeSum = 0

    func sumEvenGrandparent(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }

        calculateEvenGrandparent(root)

        return grandparentNodeSum
    }

    private func calculateEvenGrandparent(_ root: TreeNode?) {
        guard let currentNode = root else { return }

        let currentNodeValue = currentNode.val
        let isCurrentNodeEven = currentNodeValue % 2 == 0

        if isCurrentNodeEven {
            if let leftLeftGrandchild = currentNode.left?.left {
                grandparentNodeSum += leftLeftGrandchild.val
            }

            if let leftRightGrandchild = currentNode.left?.right {
                grandparentNodeSum += leftRightGrandchild.val
            }

            if let rightLeftGrandchild = currentNode.right?.left {
                grandparentNodeSum += rightLeftGrandchild.val
            }

            if let rightRightGrandchild = currentNode.right?.right {
                grandparentNodeSum += rightRightGrandchild.val
            }
        }

        calculateEvenGrandparent(currentNode.left)
        calculateEvenGrandparent(currentNode.right)
    }
}
