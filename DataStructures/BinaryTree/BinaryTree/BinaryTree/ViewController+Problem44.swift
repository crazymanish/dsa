//
//  ViewController+Problem44.swift
//  BinaryTree
//
//  Created by Manish Rathi on 18/03/2022.
//

import Foundation
/*
 1161. Maximum Level Sum of a Binary Tree
 https://leetcode.com/problems/maximum-level-sum-of-a-binary-tree/
 Given the root of a binary tree, the level of its root is 1, the level of its children is 2, and so on.
 Return the smallest level x such that the sum of all the values of nodes at level x is maximal.

 Example 1:
 Input: root = [1,7,0,7,-8,null,null]
 Output: 2
 Explanation:
 Level 1 sum = 1.
 Level 2 sum = 7 + 0 = 7.
 Level 3 sum = 7 + -8 = -1.
 So we return the level with the maximum sum which is level 2.

 Example 2:
 Input: root = [989,null,10250,98693,-89388,null,null,null,-32127]
 Output: 2
 */

extension ViewController {
    func solve44() {
        print("Setting up Problem44 input!")
        let root = TreeNode(1)
        root.left = TreeNode(7)
        root.right = TreeNode(0)
        root.left?.left = TreeNode(7)
        root.left?.right = TreeNode(-8)

        let output = Solution().maxLevelSum(root)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    func maxLevelSum(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }

        var maxLevelSum = 0
        var currentLevel = 1
        var maxCurrentSum = Int64.min
        let queue = Queue<TreeNode>()
        queue.enQueue(root)

        while queue.isEmpty == false {
            var currentSum: Int64 = 0
            let queueCount = queue.count

            for _ in 0..<queueCount {
                let currentNode = queue.deQueue()!

                currentSum += Int64(currentNode.val)

                if let leftNode = currentNode.left { queue.enQueue(leftNode) }
                if let rightNode = currentNode.right { queue.enQueue(rightNode) }
            }

            if currentSum > maxCurrentSum {
                maxCurrentSum = currentSum
                maxLevelSum = currentLevel
            }
            currentLevel += 1
        }

        return maxLevelSum
    }
}
