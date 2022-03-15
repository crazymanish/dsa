//
//  ViewController+Problem27.swift
//  BinaryTree
//
//  Created by Manish Rathi on 15/03/2022.
//

import Foundation
/*
 112. Path Sum
 https://leetcode.com/problems/path-sum/
 Given the root of a binary tree and an integer targetSum, return true if the tree has a root-to-leaf path such that adding up all the values along the path equals targetSum.
 A leaf is a node with no children.

 Example 1:
 Input: root = [5,4,8,11,null,13,4,7,2,null,null,null,1], targetSum = 22
 Output: true
 Explanation: The root-to-leaf path with the target sum is shown.

 Example 2:
 Input: root = [1,2,3], targetSum = 5
 Output: false
 Explanation: There two root-to-leaf paths in the tree:
 (1 --> 2): The sum is 3.
 (1 --> 3): The sum is 4.
 There is no root-to-leaf path with sum = 5.
 */

extension ViewController {
    func solve27() {
        print("Setting up Problem27 input!")
        let root = TreeNode(1)
        root.left = TreeNode(2)
        root.right = TreeNode(3)

        let output = Solution().hasPathSum(root, 5)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    private var pathSumMap: [Int: Bool] = [:]

    func hasPathSum(_ root: TreeNode?, _ targetSum: Int) -> Bool {
        findAllPaths(root, 0)

        return pathSumMap[targetSum] != nil
    }

    private func findAllPaths(_ root: TreeNode?, _ currentSum: Int) {
        guard let currentNode = root else { return }

        let newSum = currentSum + currentNode.val

        if currentNode.left == nil && currentNode.right == nil {
            pathSumMap[newSum] = true
        }

        findAllPaths(currentNode.left, newSum)
        findAllPaths(currentNode.right, newSum)
    }
}
