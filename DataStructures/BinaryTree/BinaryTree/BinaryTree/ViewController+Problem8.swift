//
//  ViewController+Problem8.swift
//  BinaryTree
//
//  Created by Manish Rathi on 11/03/2022.
//

import Foundation
/*
 637. Average of Levels in Binary Tree
 https://leetcode.com/problems/average-of-levels-in-binary-tree/
 Given the root of a binary tree, return the average value of the nodes on each level in the form of an array. Answers within 10-5 of the actual answer will be accepted.

 Example 1:
 Input: root = [3,9,20,null,null,15,7]
 Output: [3.00000,14.50000,11.00000]
 Explanation: The average value of nodes on level 0 is 3, on level 1 is 14.5, and on level 2 is 11.
 Hence return [3, 14.5, 11].

 Example 2:
 Input: root = [3,9,20,15,7]
 Output: [3.00000,14.50000,11.00000]
 */

extension ViewController {
    func solve8() {
        print("Setting up Problem8 input!")
        let root = TreeNode(3)
        root.left = TreeNode(9)
        root.right = TreeNode(20)
        root.right?.left = TreeNode(15)
        root.right?.right = TreeNode(7)

        let output = Solution().averageOfLevels(root)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    func averageOfLevels(_ root: TreeNode?) -> [Double] {
        guard let rootNode = root else { return [] }

        var averageOfLevels: [Double] = []
        let queue = Queue<TreeNode>()
        queue.enQueue(rootNode)

        while queue.isEmpty == false {
            var currentLevelSum = 0
            var currentLevelNodes: [TreeNode] = []

            while queue.isEmpty == false {
                let currentNode = queue.deQueue()!
                currentLevelNodes.append(currentNode)
            }

            for node in currentLevelNodes {
                currentLevelSum += node.val

                if let left = node.left { queue.enQueue(left) }
                if let right = node.right { queue.enQueue(right) }
            }

            let currentLevelAverage = Double(currentLevelSum) / Double(currentLevelNodes.count)
            averageOfLevels.append(currentLevelAverage)
        }

        return averageOfLevels
    }
}
