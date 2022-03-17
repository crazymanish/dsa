//
//  ViewController+Problem38.swift
//  BinaryTree
//
//  Created by Manish Rathi on 17/03/2022.
//

import Foundation
/*
 1448. Count Good Nodes in Binary Tree
 https://leetcode.com/problems/count-good-nodes-in-binary-tree/
 Given a binary tree root, a node X in the tree is named good if in the path from root to X there are no nodes with a value greater than X.

 Return the number of good nodes in the binary tree.

 Example 1:
 Input: root = [3,1,4,3,null,1,5]
 Output: 4
 Explanation: Nodes in blue are good.
 Root Node (3) is always a good node.
 Node 4 -> (3,4) is the maximum value in the path starting from the root.
 Node 5 -> (3,4,5) is the maximum value in the path
 Node 3 -> (3,1,3) is the maximum value in the path.

 Example 2:
 Input: root = [3,3,null,4,2]
 Output: 3
 Explanation: Node 2 -> (3, 3, 2) is not good, because "3" is higher than it.

 Example 3:
 Input: root = [1]
 Output: 1
 Explanation: Root is considered as good..
 */

extension ViewController {
    func solve38() {
        print("Setting up Problem38 input!")
        let root = TreeNode(3)
        root.left = TreeNode(1)
        root.right = TreeNode(4)
        root.left?.left = TreeNode(3)
        root.right?.left = TreeNode(1)
        root.right?.right = TreeNode(5)

        let output = Solution().goodNodes(root)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    private var goodNodes = 0

    func goodNodes(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }

        findGoodNodes(root, currentPathMaxNode: root.val)

        return goodNodes
    }

    private func findGoodNodes(_ root: TreeNode?, currentPathMaxNode: Int) {
        guard let currentNode = root else { return }

        var newMaxNodeValue = currentPathMaxNode
        if currentNode.val >= currentPathMaxNode {
            newMaxNodeValue = currentNode.val

            goodNodes += 1
        }

        findGoodNodes(currentNode.left, currentPathMaxNode: newMaxNodeValue)
        findGoodNodes(currentNode.right, currentPathMaxNode: newMaxNodeValue)
    }
}
