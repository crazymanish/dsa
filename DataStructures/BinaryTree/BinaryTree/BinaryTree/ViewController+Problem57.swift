//
//  ViewController+Problem57.swift
//  BinaryTree
//
//  Created by Manish Rathi on 19/03/2022.
//

import Foundation
/*
 103. Binary Tree Zigzag Level Order Traversal
 https://leetcode.com/problems/binary-tree-zigzag-level-order-traversal/
 Given the root of a binary tree, return the zigzag level order traversal of its nodes' values. (i.e., from left to right, then right to left for the next level and alternate between).

 Example 1:
 Input: root = [3,9,20,null,null,15,7]
 Output: [[3],[20,9],[15,7]]

 Example 2:
 Input: root = [1]
 Output: [[1]]

 Example 3:
 Input: root = []
 Output: []
 */

extension ViewController {
    func solve57() {
        print("Setting up Problem57 input!")
        let root = TreeNode(3)
        root.left = TreeNode(9)
        root.right = TreeNode(20)
        root.right?.left = TreeNode(15)
        root.right?.right = TreeNode(7)

        let output = Solution().zigzagLevelOrder(root)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else { return [] }

        var outputArray: [[Int]] = []
        var zigzagFlag = true
        let queue = Queue<TreeNode>()
        queue.enQueue(root)

        while queue.isEmpty == false {
            var currentLevelValues: [Int] = []
            let stack = Stack<Int>()
            let queueCount = queue.count

            for _ in 0..<queueCount {
                let currentNode = queue.deQueue()!

                if zigzagFlag {
                    currentLevelValues.append(currentNode.val)
                } else {
                    stack.push(currentNode.val)
                }

                if let leftNode = currentNode.left { queue.enQueue(leftNode) }
                if let rightNode = currentNode.right { queue.enQueue(rightNode) }
            }

            while stack.isEmpty == false { currentLevelValues.append(stack.pop()!) }

            outputArray.append(currentLevelValues)
            zigzagFlag.toggle()
        }

        return outputArray
    }
}
