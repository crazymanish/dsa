//
//  ViewController+Problem21.swift
//  BinaryTree
//
//  Created by Manish Rathi on 14/03/2022.
//

import Foundation
/*
 404. Sum of Left Leaves
 https://leetcode.com/problems/sum-of-left-leaves/
 Given the root of a binary tree, return the sum of all left leaves.

 Example 1:
 Input: root = [3,9,20,null,null,15,7]
 Output: 24
 Explanation: There are two left leaves in the binary tree, with values 9 and 15 respectively.

 Example 2:
 Input: root = [1]
 Output: 0
 */

extension ViewController {
    func solve21() {
        print("Setting up Problem21 input!")
        let root = TreeNode(1)
        root.left = TreeNode(2)
        root.right = TreeNode(3)
        root.left?.left = TreeNode(4)
        root.left?.right = TreeNode(5)

        let output = Solution().sumOfLeftLeaves(root)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    func sumOfLeftLeaves(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }

        var outputSum = 0
        let queue = Queue<TreeNode>()
        queue.enQueue(root)

        while queue.isEmpty == false {
            let currentNode = queue.deQueue()!

            if let leftNode = currentNode.left {
                queue.enQueue(leftNode)

                if leftNode.left == nil, leftNode.right == nil {
                    outputSum += leftNode.val
                }
            }

            if let rightNode = currentNode.right {
                queue.enQueue(rightNode)
            }
        }

        return outputSum
    }
}
