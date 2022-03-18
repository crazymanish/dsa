//
//  ViewController+Problem48.swift
//  BinaryTree
//
//  Created by Manish Rathi on 18/03/2022.
//

import Foundation
/*
 515. Find Largest Value in Each Tree Row
 https://leetcode.com/problems/find-largest-value-in-each-tree-row/
 Given the root of a binary tree, return the leftmost value in the last row of the tree.

 Example 1:
 Input: root = [2,1,3]
 Output: 1

 Example 2:
 Input: root = [1,2,3,4,null,5,6,null,null,7]
 Output: 7
 */

extension ViewController {
    func solve48() {
        print("Setting up Problem48 input!")
        let root = TreeNode(1)
        root.left = TreeNode(3)
        root.right = TreeNode(2)
        root.left?.left = TreeNode(5)
        root.left?.right = TreeNode(3)
        root.right?.right = TreeNode(9)

        let output = Solution().largestValues(root)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    func largestValues(_ root: TreeNode?) -> [Int] {
        guard let root = root else { return [] }

        var largestValues: [Int] = []
        let queue = Queue<TreeNode>()
        queue.enQueue(root)

        while queue.isEmpty == false {
            let queueCount = queue.count
            var currentLevelLargestValue = Int.min

            for _ in 0..<queueCount {
                let currentNode = queue.deQueue()!

                currentLevelLargestValue = max(currentLevelLargestValue, currentNode.val)

                if let leftNode = currentNode.left { queue.enQueue(leftNode) }
                if let rightNode = currentNode.right { queue.enQueue(rightNode) }
            }

            largestValues.append(currentLevelLargestValue)
        }

        return largestValues
    }
}
