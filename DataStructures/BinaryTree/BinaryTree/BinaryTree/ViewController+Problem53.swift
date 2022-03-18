//
//  ViewController+Problem53.swift
//  BinaryTree
//
//  Created by Manish Rathi on 18/03/2022.
//

import Foundation
/*
 113. Path Sum II
 https://leetcode.com/problems/path-sum-ii/
 Given the root of a binary tree and an integer targetSum, return all root-to-leaf paths where the sum of the node values in the path equals targetSum. Each path should be returned as a list of the node values, not node references.
 A root-to-leaf path is a path starting from the root and ending at any leaf node. A leaf is a node with no children.

 Example 1:
 Input: root = [5,4,8,11,null,13,4,7,2,null,null,5,1], targetSum = 22
 Output: [[5,4,11,2],[5,8,4,5]]
 Explanation: There are two paths whose sum equals targetSum:
 5 + 4 + 11 + 2 = 22
 5 + 8 + 4 + 5 = 22

 Example 2:
 Input: root = [1,2,3], targetSum = 5
 Output: []

 Example 3:
 Input: root = [1,2], targetSum = 0
 Output: []
 */

extension ViewController {
    func solve53() {
        print("Setting up Problem53 input!")
        let root = TreeNode(5)
        root.left = TreeNode(4)
        root.right = TreeNode(8)
        root.left?.left = TreeNode(11)
        root.left?.left?.left = TreeNode(7)
        root.left?.left?.right = TreeNode(2)
        root.right?.left = TreeNode(13)
        root.right?.right = TreeNode(4)
        root.right?.right?.left = TreeNode(5)
        root.right?.right?.right = TreeNode(1)

        let output = Solution().pathSum(root, 22)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    private var hashMap: [Int: [[Int]]] = [:]

    func pathSum(_ root: TreeNode?, _ targetSum: Int) -> [[Int]] {
        guard let root = root else { return [] }

        findAllPathSum(root, targetSum, 0, [])

        return hashMap[targetSum] ?? []
    }

    private func findAllPathSum(_ root: TreeNode?, _ targetSum: Int, _ currentSum: Int, _ currentElements: [Int]) {
        guard let currentNode = root else { return }

        let newSum = currentSum + currentNode.val
        let newElements = currentElements + [currentNode.val]

        if currentNode.isLeafNode && newSum == targetSum {
            if let cacheElements = hashMap[newSum] {
                hashMap[newSum] = cacheElements + [newElements]
            } else {
                hashMap[newSum] = [newElements]
            }
        }

        findAllPathSum(currentNode.left, targetSum, newSum, newElements)
        findAllPathSum(currentNode.right, targetSum, newSum, newElements)
    }
}

private extension TreeNode {
    var isLeafNode: Bool { left == nil && right == nil }
}
