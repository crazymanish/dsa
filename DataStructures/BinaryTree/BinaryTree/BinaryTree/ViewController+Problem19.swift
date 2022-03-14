//
//  ViewController+Problem19.swift
//  BinaryTree
//
//  Created by Manish Rathi on 14/03/2022.
//

import Foundation
/*
 783. Minimum Distance Between BST Nodes
 https://leetcode.com/problems/minimum-distance-between-bst-nodes/
 Given the root of a Binary Search Tree (BST), return the minimum difference between the values of any two different nodes in the tree.

 Example 1:
 Input: root = [4,2,6,1,3]
 Output: 1

 Example 2:
 Input: root = [1,0,48,null,null,12,49]
 Output: 1
 */

extension ViewController {
    func solve19() {
        print("Setting up Problem19 input!")
        let root = TreeNode(4)
        root.left = TreeNode(2)
        root.right = TreeNode(6)
        root.left?.left = TreeNode(1)
        root.left?.right = TreeNode(3)

        let output = Solution().minDiffInBST(root)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    private var minimumDifference = Int.max
    private var previousNode: TreeNode? = nil

    func minDiffInBST(_ root: TreeNode?) -> Int {
        calculateMinimumDifferenceUsingInorderTraversalInBST(root)

        return minimumDifference
    }

    private func calculateMinimumDifferenceUsingInorderTraversalInBST(_ root: TreeNode?) {
        guard let currentNode = root else { return }

        calculateMinimumDifferenceUsingInorderTraversalInBST(currentNode.left)

        if let previousNode = previousNode {
            let currentNodeDifference = abs(previousNode.val - currentNode.val)
            minimumDifference = min(minimumDifference, currentNodeDifference)
        }

        previousNode = currentNode

        calculateMinimumDifferenceUsingInorderTraversalInBST(currentNode.right)
    }
}
