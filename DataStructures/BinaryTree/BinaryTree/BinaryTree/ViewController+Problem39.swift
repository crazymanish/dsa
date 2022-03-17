//
//  ViewController+Problem39.swift
//  BinaryTree
//
//  Created by Manish Rathi on 17/03/2022.
//

import Foundation
/*
 1026. Maximum Difference Between Node and Ancestor
 https://leetcode.com/problems/maximum-difference-between-node-and-ancestor/
 Given the root of a binary tree, find the maximum value v for which there exist different nodes a and b where v = |a.val - b.val| and a is an ancestor of b.
 A node a is an ancestor of b if either: any child of a is equal to b or any child of a is an ancestor of b.

 Example 1:
 Input: root = [8,3,10,1,6,null,14,null,null,4,7,13]
 Output: 7
 Explanation: We have various ancestor-node differences, some of which are given below :
 |8 - 3| = 5
 |3 - 7| = 4
 |8 - 1| = 7
 |10 - 13| = 3
 Among all possible differences, the maximum value of 7 is obtained by |8 - 1| = 7.

 Example 2:
 Input: root = [1,null,2,null,0,3]
 Output: 3
 */

extension ViewController {
    func solve39() {
        print("Setting up Problem39 input!")
        let root = TreeNode(8)
        root.left = TreeNode(3)
        root.right = TreeNode(10)
        root.left?.left = TreeNode(1)
        root.left?.right = TreeNode(6)
        root.right?.right = TreeNode(14)
        root.left?.right?.left = TreeNode(4)
        root.left?.right?.right = TreeNode(7)
        root.right?.right?.left = TreeNode(13)

        let output = Solution().maxAncestorDiff(root)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    private var maxAncestorDifference = Int.min

    func maxAncestorDiff(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }

        findMaxAncestorDiff(root, root.val, root.val)

        return maxAncestorDifference
    }

    private func findMaxAncestorDiff(_ root: TreeNode?, _ currentPathMinValueNode: Int, _ currentPathMaxValueNode: Int) {
        guard let currentNode = root else { return }

        let newMinValueNode = min(abs(currentNode.val), abs(currentPathMinValueNode))
        let newMaxValueNode = max(abs(currentNode.val), abs(currentPathMaxValueNode))

        if currentNode.isLeafNode {
            let currentPathAncestorDifference = abs(newMaxValueNode - newMinValueNode)
            maxAncestorDifference = max(currentPathAncestorDifference, maxAncestorDifference)
        }

        findMaxAncestorDiff(currentNode.left, newMinValueNode, newMaxValueNode)
        findMaxAncestorDiff(currentNode.right, newMinValueNode, newMaxValueNode)
    }
}

private extension TreeNode {
    var isLeafNode: Bool { left == nil && right == nil }
}
