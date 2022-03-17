//
//  ViewController+Problem40.swift
//  BinaryTree
//
//  Created by Manish Rathi on 17/03/2022.
//

import Foundation
/*
 1123. Lowest Common Ancestor of Deepest Leaves
 https://leetcode.com/problems/lowest-common-ancestor-of-deepest-leaves/
 Given the root of a binary tree, return the lowest common ancestor of its deepest leaves.

 Recall that:
 The node of a binary tree is a leaf if and only if it has no children
 The depth of the root of the tree is 0. if the depth of a node is d, the depth of each of its children is d + 1.
 The lowest common ancestor of a set S of nodes, is the node A with the largest depth such that every node in S is in the subtree with root A.


 Example 1:
 Input: root = [3,5,1,6,2,0,8,null,null,7,4]
 Output: [2,7,4]
 Explanation: We return the node with value 2, colored in yellow in the diagram.
 The nodes coloured in blue are the deepest leaf-nodes of the tree.
 Note that nodes 6, 0, and 8 are also leaf nodes, but the depth of them is 2, but the depth of nodes 7 and 4 is 3.

 Example 2:
 Input: root = [1]
 Output: [1]
 Explanation: The root is the deepest node in the tree, and it's the lca of itself.

 Example 3:
 Input: root = [0,1,3,null,2]
 Output: [2]
 Explanation: The deepest leaf node in the tree is 2, the lca of one node is itself.
 */

extension ViewController {
    func solve40() {
        print("Setting up Problem40 input!")
        let root = TreeNode(3)
        root.left = TreeNode(5)
        root.right = TreeNode(1)
        root.left?.left = TreeNode(6)
        root.left?.right = TreeNode(2)
        root.right?.left = TreeNode(0)
        root.right?.right = TreeNode(8)
        root.left?.right?.left = TreeNode(7)
        root.left?.right?.right = TreeNode(4)

        let output = Solution().lcaDeepestLeaves(root)
        print("Output: \(output!.inorderTraversal)")
    }
}

fileprivate class Solution {
    func lcaDeepestLeaves(_ root: TreeNode?) -> TreeNode? {
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
