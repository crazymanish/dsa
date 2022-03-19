//
//  ViewController+Problem60.swift
//  BinaryTree
//
//  Created by Manish Rathi on 19/03/2022.
//

import Foundation
/*
 865. Smallest Subtree with all the Deepest Nodes
 https://leetcode.com/problems/smallest-subtree-with-all-the-deepest-nodes/
 Given the root of a binary tree, the depth of each node is the shortest distance to the root.
 Return the smallest subtree such that it contains all the deepest nodes in the original tree.
 A node is called the deepest if it has the largest depth possible among any node in the entire tree.
 The subtree of a node is a tree consisting of that node, plus the set of all descendants of that node.

 Example 1:
 Input: root = [3,5,1,6,2,0,8,null,null,7,4]
 Output: [2,7,4]
 Explanation: We return the node with value 2, colored in yellow in the diagram.
 The nodes coloured in blue are the deepest nodes of the tree.
 Notice that nodes 5, 3 and 2 contain the deepest nodes in the tree but node 2 is the smallest subtree among them, so we return it.

 Example 2:
 Input: root = [1]
 Output: [1]
 Explanation: The root is the deepest node in the tree.

 Example 3:
 Input: root = [0,1,3,null,2]
 Output: [2]
 Explanation: The deepest node in the tree is 2, the valid subtrees are the subtrees of nodes 2, 1 and 0 but the subtree of node 2 is the smallest.
 */

extension ViewController {
    func solve60() {
        print("Setting up Problem60 input!")
        let root = TreeNode(3)
        root.left = TreeNode(5)
        root.right = TreeNode(1)
        root.left?.left = TreeNode(6)
        root.left?.right = TreeNode(2)
        root.right?.left = TreeNode(0)
        root.right?.right = TreeNode(8)
        root.left?.right?.left = TreeNode(7)
        root.left?.right?.right = TreeNode(4)

        print("Input: \(root.inorderTraversal)")
        let output = Solution().subtreeWithAllDeepest(root)
        print("Output: \(output!.inorderTraversal)")
    }
}

fileprivate class Solution {
    func subtreeWithAllDeepest(_ root: TreeNode?) -> TreeNode? {
        guard let root = root else { return nil }
        let maximumDepth = calculateDepth(root) - 1

        return findLcaNode(root, 0, maximumDepth)
    }

    private func calculateDepth(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }

        let leftHeight = calculateDepth(root.left)
        let rightHeight = calculateDepth(root.right)

        return max(leftHeight, rightHeight) + 1
    }

    private func findLcaNode(_ root: TreeNode?, _ currentDepth: Int, _ maximumDepth: Int) -> TreeNode? {
        guard let currentNode = root else { return nil }

        if currentDepth == maximumDepth { return currentNode }

        let newDepth = currentDepth + 1
        let leftLcaNode = findLcaNode(currentNode.left, newDepth, maximumDepth)
        let rightLcaNode = findLcaNode(currentNode.right, newDepth, maximumDepth)

        if leftLcaNode != nil && rightLcaNode != nil {
            return currentNode
        } else if leftLcaNode != nil {
            return leftLcaNode
        } else {
            return rightLcaNode
        }
    }
}
