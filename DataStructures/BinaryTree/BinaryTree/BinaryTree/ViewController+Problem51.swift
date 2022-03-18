//
//  ViewController+Problem51.swift
//  BinaryTree
//
//  Created by Manish Rathi on 18/03/2022.
//

import Foundation
/*
 199. Binary Tree Right Side View
 https://leetcode.com/problems/binary-tree-right-side-view/
 Given the root of a binary tree, imagine yourself standing on the right side of it, return the values of the nodes you can see ordered from top to bottom.

 Example 1:
 Input: root = [1,2,3,null,5,null,4]
 Output: [1,3,4]

 Example 2:
 Input: root = [1,null,3]
 Output: [1,3]

 Example 3:
 Input: root = []
 Output: []
 */

extension ViewController {
    func solve51() {
        print("Setting up Problem51 input!")
        let root = TreeNode(1)
        root.left = TreeNode(2)
        root.right = TreeNode(3)
        root.left?.right = TreeNode(5)
        root.right?.right = TreeNode(4)

        let output = Solution().rightSideView(root)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    func rightSideView(_ root: TreeNode?) -> [Int] {
        guard let root = root else { return [] }

        var rightSideViewValues: [Int] = []
        let queue = Queue<TreeNode>()
        queue.enQueue(root)

        while queue.isEmpty == false {
            let queueCount = queue.count
            var currentLevelRightSideViewValue = 0

            for index in 0..<queueCount {
                let currentNode = queue.deQueue()!

                if index == queueCount-1 { currentLevelRightSideViewValue = currentNode.val }

                if let leftNode = currentNode.left { queue.enQueue(leftNode) }
                if let rightNode = currentNode.right { queue.enQueue(rightNode) }
            }

            rightSideViewValues.append(currentLevelRightSideViewValue)
        }

        return rightSideViewValues
    }
}
