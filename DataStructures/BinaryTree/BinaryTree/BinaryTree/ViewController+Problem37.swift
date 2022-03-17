//
//  ViewController+Problem37.swift
//  BinaryTree
//
//  Created by Manish Rathi on 17/03/2022.
//

import Foundation
/*
 1325. Delete Leaves With a Given Value
 https://leetcode.com/problems/delete-leaves-with-a-given-value/
 Given a binary tree root and an integer target, delete all the leaf nodes with value target.
 Note that once you delete a leaf node with value target, if its parent node becomes a leaf node and has the value target, it should also be deleted (you need to continue doing that until you cannot).

 Example 1:
 Input: root = [1,2,3,2,null,2,4], target = 2
 Output: [1,null,3,null,4]
 Explanation: Leaf nodes in green with value (target = 2) are removed (Picture in left).
 After removing, new nodes become leaf nodes with value (target = 2) (Picture in center).

 Example 2:
 Input: root = [1,3,3,3,2], target = 3
 Output: [1,3,null,null,2]

 Example 3:
 Input: root = [1,2,null,2,null,2], target = 2
 Output: [1]
 Explanation: Leaf nodes in green with value (target = 2) are removed at each step.
 */

extension ViewController {
    func solve37() {
        print("Setting up Problem37 input!")
        let root = TreeNode(1)
        root.left = TreeNode(2)
        root.right = TreeNode(3)
        root.left?.left = TreeNode(2)
        root.right?.left = TreeNode(2)
        root.right?.right = TreeNode(4)

        let output = Solution().removeLeafNodes(root, 2)
        print("Output: \(output!.inorderTraversal)")
    }
}

fileprivate class Solution {
    private var canRemoveMoreLeafNodes = true

    func removeLeafNodes(_ root: TreeNode?, _ target: Int) -> TreeNode? {
        guard let root = root else { return nil }

        while canRemoveMoreLeafNodes {
            canRemoveMoreLeafNodes = deleteLeafNodes(root, target)
        }

        return root.val == target && root.isLeafNode ? nil : root
    }

    private func deleteLeafNodes(_ root: TreeNode?, _ target: Int) -> Bool {
        guard let currentNode = root else { return false }

        let isCurrentNodeLeafDeleted = currentNode.deleteLeafNodeIfPossible(target)

        let isLeftLeafDeleted = deleteLeafNodes(currentNode.left, target)
        let isRightLeafDeleted = deleteLeafNodes(currentNode.right, target)

        return isCurrentNodeLeafDeleted || isLeftLeafDeleted || isRightLeafDeleted
    }
}

fileprivate extension TreeNode {
    var isLeafNode: Bool {
        return left == nil && right == nil
    }

    func deleteLeafNodeIfPossible(_ target: Int) -> Bool {
        var isDeletedLeafNode = false

        if let leftChild = left, leftChild.val == target, leftChild.isLeafNode {
            left = nil
            isDeletedLeafNode = true
        }

        if let rightChild = right, rightChild.val == target, rightChild.isLeafNode {
            right = nil
            isDeletedLeafNode = true
        }

        return isDeletedLeafNode
    }
}
