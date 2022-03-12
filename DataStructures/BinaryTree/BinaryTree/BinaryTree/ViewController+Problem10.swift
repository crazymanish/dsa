//
//  ViewController+Problem10.swift
//  BinaryTree
//
//  Created by Manish Rathi on 12/03/2022.
//

import Foundation
/*
 872. Leaf-Similar Trees
 https://leetcode.com/problems/leaf-similar-trees/

 Consider all the leaves of a binary tree, from left to right order, the values of those leaves form a leaf value sequence.
 For example, in the given tree above, the leaf value sequence is (6, 7, 4, 9, 8).
 Two binary trees are considered leaf-similar if their leaf value sequence is the same.
 Return true if and only if the two given trees with head nodes root1 and root2 are leaf-similar.

 Example 1:
 Input: root1 = [3,5,1,6,2,9,8,null,null,7,4], root2 = [3,5,1,6,7,4,2,null,null,null,null,null,null,9,8]
 Output: true

 Example 2:
 Input: root1 = [1,2,3], root2 = [1,3,2]
 Output: false
 */

extension ViewController {
    func solve10() {
        print("Setting up Problem10 input!")
        let root1 = TreeNode(1)
        root1.left = TreeNode(2)
        root1.right = TreeNode(3)

        let root2 = TreeNode(1)
        root2.left = TreeNode(3)
        root2.right = TreeNode(2)

        let output = Solution().leafSimilar(root1, root2)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    func leafSimilar(_ root1: TreeNode?, _ root2: TreeNode?) -> Bool {
        guard let root1 = root1, let root2 = root2 else { return false }

        let leftLeafNodes = leafNodes(root1)
        let rightLeafNodes = leafNodes(root2)

        return leftLeafNodes == rightLeafNodes
    }

    private func leafNodes(_ root: TreeNode?) -> [Int] {
        guard let rootNode = root else { return [] }

        if rootNode.left == nil && rootNode.right == nil { return [rootNode.val] }

        let leftLeafNodes = leafNodes(rootNode.left)
        let rightLeafNodes = leafNodes(rootNode.right)

        return leftLeafNodes + rightLeafNodes
    }
}
