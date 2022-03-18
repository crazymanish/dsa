//
//  ViewController+Problem47.swift
//  BinaryTree
//
//  Created by Manish Rathi on 18/03/2022.
//

import Foundation
/*
 513. Find Bottom Left Tree Value
 https://leetcode.com/problems/find-bottom-left-tree-value/
 Given the root of a binary tree, return the leftmost value in the last row of the tree.

 Example 1:
 Input: root = [2,1,3]
 Output: 1

 Example 2:
 Input: root = [1,2,3,4,null,5,6,null,null,7]
 Output: 7
 */

extension ViewController {
    func solve47() {
        print("Setting up Problem47 input!")
        let root = TreeNode(2)
        root.left = TreeNode(1)
        root.right = TreeNode(3)

        let output = Solution().findBottomLeftValue(root)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    func findBottomLeftValue(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }

        var leftMostValue = 0
        let queue = Queue<TreeNode>()
        queue.enQueue(root)

        while queue.isEmpty == false {
            let queueCount = queue.count

            for index in 0..<queueCount {
                let currentNode = queue.deQueue()!

                if index == 0 { leftMostValue = currentNode.val }

                if let leftNode = currentNode.left { queue.enQueue(leftNode) }
                if let rightNode = currentNode.right { queue.enQueue(rightNode) }
            }
        }

        return leftMostValue
    }
}
