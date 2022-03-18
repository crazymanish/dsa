//
//  ViewController+Problem49.swift
//  BinaryTree
//
//  Created by Manish Rathi on 18/03/2022.
//

import Foundation
/*
 102. Binary Tree Level Order Traversal
 https://leetcode.com/problems/binary-tree-level-order-traversal/
 Given the root of a binary tree, return the level order traversal of its nodes' values. (i.e., from left to right, level by level).

 Example 1:
 Input: root = [3,9,20,null,null,15,7]
 Output: [[3],[9,20],[15,7]]

 Example 2:
 Input: root = [1]
 Output: [[1]]

 Example 3:
 Input: root = []
 Output: []
 */

extension ViewController {
    func solve49() {
        print("Setting up Problem49 input!")
        let root = TreeNode(3)
        root.left = TreeNode(9)
        root.right = TreeNode(20)
        root.right?.left = TreeNode(15)
        root.right?.right = TreeNode(7)

        let output = Solution().levelOrder(root)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else { return [] }

        var levelOrderValues: [[Int]] = []
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

            levelOrderValues.append(currentLevelValues)
        }

        return levelOrderValues
    }
}
