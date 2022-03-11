//
//  ViewController+Problem7.swift
//  BinaryTree
//
//  Created by Manish Rathi on 11/03/2022.
//

import Foundation
/*
 965. Univalued Binary Tree
 https://leetcode.com/problems/univalued-binary-tree/
 A binary tree is uni-valued if every node in the tree has the same value.
 Given the root of a binary tree, return true if the given tree is uni-valued, or false otherwise.

 Example 1:
 Input: root = [1,1,1,1,1,null,1]
 Output: true

 Example 2:
 Input: root = [2,2,2,5,2]
 Output: false
 */

extension ViewController {
    func solve7() {
        print("Setting up Problem7 input!")
        var root = TreeNode(1)
        root.left = TreeNode(1)
        root.right = TreeNode(1)
        root.left?.left = TreeNode(1)
        root.left?.right = TreeNode(1)
        root.right?.right = TreeNode(1)

        var output = Solution().isUnivalTree(root)
        print("Output: \(output)")

        print("Setting up Problem7 input! - #take2")
        root = TreeNode(2)
        root.left = TreeNode(2)
        root.right = TreeNode(2)
        root.left?.left = TreeNode(5)
        root.left?.right = TreeNode(2)

        output = Solution().isUnivalTree(root)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    func isUnivalTree(_ root: TreeNode?) -> Bool {
        guard let rootNode = root else { return true }

        if let left = rootNode.left, left.val != rootNode.val { return false }
        if let right = rootNode.right, right.val != rootNode.val { return false }

        let isLeftUnivalTree = isUnivalTree(rootNode.left)
        let isRightUnivalTree = isUnivalTree(rootNode.right)

        return isLeftUnivalTree && isRightUnivalTree
    }
}
