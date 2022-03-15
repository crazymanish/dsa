//
//  ViewController+Problem25.swift
//  BinaryTree
//
//  Created by Manish Rathi on 15/03/2022.
//

import Foundation
/*
 501. Find Mode in Binary Search Tree
 https://leetcode.com/problems/find-mode-in-binary-search-tree/
 Given the root of a binary search tree (BST) with duplicates, return all the mode(s) (i.e., the most frequently occurred element) in it.
 If the tree has more than one mode, return them in any order.

 Assume a BST is defined as follows:
 The left subtree of a node contains only nodes with keys less than or equal to the node's key.
 The right subtree of a node contains only nodes with keys greater than or equal to the node's key.
 Both the left and right subtrees must also be binary search trees.

 Example 1:
 Input: root = [1,null,2,2]
 Output: [2]

 Example 2:
 Input: root = [0]
 Output: [0]
 */

extension ViewController {
    func solve25() {
        print("Setting up Problem25 input!")
        let root = TreeNode(1)
        root.left = TreeNode(0)
        root.right = TreeNode(1)
        root.left?.left = TreeNode(0)
        root.left?.right = TreeNode(0)
        root.right?.left = TreeNode(1)
        root.right?.right = TreeNode(1)
        root.left?.left?.left = TreeNode(0)

        let output = Solution().findMode(root)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    private var nodeValueCounterMap: [Int : Int] = [:]
    private var maximumCounter: Int = Int.min

    func findMode(_ root: TreeNode?) -> [Int] {
        guard let currentNode = root else { return [] }

        findRecursiveMode(currentNode)

        var outputResults: [Int] = []

        for (key, value) in nodeValueCounterMap {
            if value == maximumCounter { outputResults.append(key) }
        }

        return outputResults
    }

    private func findRecursiveMode(_ root: TreeNode?) {
        guard let currentNode = root else { return }

        let currentNodeValue = currentNode.val
        let currentNodeCounter: Int

        if let cacheCounter = nodeValueCounterMap[currentNodeValue] {
            currentNodeCounter = cacheCounter + 1
        } else {
            currentNodeCounter = 0
        }

        nodeValueCounterMap[currentNodeValue] = currentNodeCounter

        maximumCounter = max(maximumCounter, currentNodeCounter)

        findRecursiveMode(currentNode.left)
        findRecursiveMode(currentNode.right)
    }
}
