//
//  ViewController+Problem50.swift
//  BinaryTree
//
//  Created by Manish Rathi on 18/03/2022.
//

import Foundation
/*
 107. Binary Tree Level Order Traversal II
 https://leetcode.com/problems/binary-tree-level-order-traversal-ii/
 Given the root of a binary tree, return the bottom-up level order traversal of its nodes' values. (i.e., from left to right, level by level from leaf to root).

 Example 1:
 Input: root = [3,9,20,null,null,15,7]
 Output: [[15,7],[9,20],[3]]

 Example 2:
 Input: root = [1]
 Output: [[1]]

 Example 3:
 Input: root = []
 Output: []
 */

extension ViewController {
    func solve50() {
        print("Setting up Problem50 input!")
        let root = TreeNode(3)
        root.left = TreeNode(9)
        root.right = TreeNode(20)
        root.right?.left = TreeNode(15)
        root.right?.right = TreeNode(7)

        let output = Solution().levelOrderBottom(root)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    func levelOrderBottom(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else { return [] }

        var levelOrderValues: [[Int]] = []
        let stack = Stack<[Int]>()
        let queue = Queue<TreeNode>()
        queue.enQueue(root)

        while queue.isEmpty == false {
            let queueCount = queue.count
            var currentLevelValues: [Int] = []

            for _ in 0..<queueCount {
                let currentNode = queue.deQueue()!

                currentLevelValues.append(currentNode.val)

                if let leftNode = currentNode.left { queue.enQueue(leftNode) }
                if let rightNode = currentNode.right { queue.enQueue(rightNode) }
            }

            stack.push(currentLevelValues)
        }

        while stack.isEmpty == false {
            levelOrderValues.append(stack.pop()!)
        }

        return levelOrderValues
    }
}
