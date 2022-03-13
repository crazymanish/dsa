//
//  ViewController+Problem15.swift
//  BinaryTree
//
//  Created by Manish Rathi on 13/03/2022.
//

import Foundation
/*
 257. Binary Tree Paths
 https://leetcode.com/problems/binary-tree-paths/
 Given the root of a binary tree, return all root-to-leaf paths in any order.
 A leaf is a node with no children.

 Example 1:
 Input: root = [1,2,3,null,5]
 Output: ["1->2->5","1->3"]

 Example 2:
 Input: root = [1]
 Output: ["1"]
 */

extension ViewController {
    func solve15() {
        print("Setting up Problem15 input!")
        let root = TreeNode(1)
        root.left = TreeNode(2)
        root.right = TreeNode(3)

        let output = Solution().binaryTreePaths(root)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    func binaryTreePaths(_ root: TreeNode?) -> [String] {
        guard let root = root else { return [] }

        var output: [String] = []

        let queue = Queue<Array<String>>()
        findAllPaths(root, queue: queue, currentPathNodes: [])

        while queue.isEmpty == false {
            let currentPathNodes = queue.deQueue()!
            let currentPath = currentPathNodes.joined(separator: "->")

            output.append(currentPath)
        }

        return output
    }

    private func findAllPaths(_ root: TreeNode?, queue: Queue<Array<String>>, currentPathNodes: [String]) {
        if root == nil { return }

        let newPathNodes = currentPathNodes + [String(root!.val)]

        if root?.left == nil && root?.right == nil {
            queue.enQueue(newPathNodes)
        } else {
            findAllPaths(root?.left, queue: queue, currentPathNodes: newPathNodes)
            findAllPaths(root?.right, queue: queue, currentPathNodes: newPathNodes)
        }
    }
}
