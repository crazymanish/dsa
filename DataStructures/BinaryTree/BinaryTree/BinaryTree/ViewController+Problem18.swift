//
//  ViewController+Problem18.swift
//  BinaryTree
//
//  Created by Manish Rathi on 13/03/2022.
//

import Foundation
/*
 530. Minimum Absolute Difference in BST
 https://leetcode.com/problems/minimum-absolute-difference-in-bst/
 Given the root of a Binary Search Tree (BST), return the minimum absolute difference between the values of any two different nodes in the tree.

 Example 1:
 Input: root = [4,2,6,1,3]
 Output: 1

 Example 2:
 Input: root = [1,0,48,null,null,12,49]
 Output: 1
 */

extension ViewController {
    func solve18() {
        print("Setting up Problem18 input!")
        let root = TreeNode(4)
        root.left = TreeNode(2)
        root.right = TreeNode(6)
        root.left?.left = TreeNode(1)
        root.left?.right = TreeNode(3)

        let output = Solution().getMinimumDifference(root)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    private var minimumDifference = Int.max
    private var previousNode: TreeNode? = nil

    func getMinimumDifference(_ root: TreeNode?) -> Int {
        findMinimumDifference(root)

        return minimumDifference
    }

    private func findMinimumDifference(_ currentNode: TreeNode?) {
        guard let currentNode = currentNode else { return }

        findMinimumDifference(currentNode.left)

        if previousNode != nil {
            let currentDifference = abs(previousNode!.val - currentNode.val)
            minimumDifference = min(minimumDifference, currentDifference)
        }

        previousNode = currentNode

        findMinimumDifference(currentNode.right)
    }
}
