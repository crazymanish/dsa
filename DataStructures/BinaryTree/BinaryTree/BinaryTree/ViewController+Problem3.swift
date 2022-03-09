//
//  ViewController+Problem3.swift
//  BinaryTree
//
//  Created by Manish Rathi on 09/03/2022.
//

import Foundation
/*
 1022. Sum of Root To Leaf Binary Numbers
 https://leetcode.com/problems/sum-of-root-to-leaf-binary-numbers/

 You are given the root of a binary tree where each node has a value 0 or 1. Each root-to-leaf path represents a binary number starting with the most significant bit.
 For example, if the path is 0 -> 1 -> 1 -> 0 -> 1, then this could represent 01101 in binary, which is 13.
 For all leaves in the tree, consider the numbers represented by the path from the root to that leaf. Return the sum of these numbers.
 The test cases are generated so that the answer fits in a 32-bits integer.

 Example 1:
 Input: root = [1,0,1,0,1,0,1]
 Output: 22
 Explanation: (100) + (101) + (110) + (111) = 4 + 5 + 6 + 7 = 22
 */



extension ViewController {
    func solve3() {
        print("Setting up Problem2 input!")
        let root = TreeNode(1)
        root.left = TreeNode(0)
        root.right = TreeNode(1)
        root.left?.left = TreeNode(0)
        root.left?.right = TreeNode(1)
        root.right?.left = TreeNode(0)
        root.right?.right = TreeNode(1)

        let output = sumRootToLeaf(root)
        print("Output: \(output as Any)")
    }

    func sumRootToLeaf(_ root: TreeNode?) -> Int {
        if root == nil { return 0 }

        var output = 0

        let queue = Queue<String>()
        findAllPaths(root, queue: queue, currentPath: "")

        while queue.isEmpty == false {
            if let currentSum = Int(queue.deQueue()!, radix: 2) {
                output += currentSum
            }
        }

        return output
    }

    func findAllPaths(_ root: TreeNode?, queue: Queue<String>, currentPath: String) {
        if root == nil { return }

        let newPath = currentPath + String(root!.val)

        if root?.left == nil && root?.right == nil {
            queue.enQueue(newPath)
        } else {
            findAllPaths(root?.left, queue: queue, currentPath: newPath)
            findAllPaths(root?.right, queue: queue, currentPath: newPath)
        }
    }
}
