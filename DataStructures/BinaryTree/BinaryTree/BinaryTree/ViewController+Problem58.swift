//
//  ViewController+Problem58.swift
//  BinaryTree
//
//  Created by Manish Rathi on 19/03/2022.
//

import Foundation
/*
 814. Binary Tree Pruning
 https://leetcode.com/problems/binary-tree-pruning/
 Given the root of a binary tree, return the same tree where every subtree (of the given tree) not containing a 1 has been removed.
 A subtree of a node node is node plus every node that is a descendant of node.

 Example 1:
 Input: root = [1,null,0,0,1]
 Output: [1,null,0,null,1]
 Explanation:
 Only the red nodes satisfy the property "every subtree not containing a 1".
 The diagram on the right represents the answer.

 Example 2:
 Input: root = [1,0,1,0,0,0,1]
 Output: [1,null,1,null,1]

 Example 3:
 Input: root = [1,1,0,1,1,0,1,0]
 Output: [1,1,0,1,1,null,1]
 */

extension ViewController {
    func solve58() {
        print("Setting up Problem58 input!")
        let root = TreeNode(1)
        root.right = TreeNode(0)
        root.right?.left = TreeNode(0)
        root.right?.right = TreeNode(1)

        print("Input: \(root.inorderTraversal)")
        let output = Solution().pruneTree(root)
        print("Output: \(output!.inorderTraversal)")
    }
}

fileprivate class Solution {
    func pruneTree(_ root: TreeNode?) -> TreeNode? {
        guard let currentNode = root else { return nil }

        if currentNode.val == 0 && currentNode.isLeafNode { return nil }

        let leftPruneTree = pruneTree(currentNode.left)
        let rightPruneTree = pruneTree(currentNode.right)

        if currentNode.val == 0 && leftPruneTree == nil && rightPruneTree == nil { return nil }

        return TreeNode(currentNode.val, leftPruneTree, rightPruneTree)
    }
}

private extension TreeNode {
    var isLeafNode: Bool { left == nil && right == nil }
}
