//
//  ViewController+Problem28.swift
//  BinaryTree
//
//  Created by Manish Rathi on 15/03/2022.
//

import Foundation
/*
 572. Subtree of Another Tree
 https://leetcode.com/problems/subtree-of-another-tree/
 Given the roots of two binary trees root and subRoot, return true if there is a subtree of root with the same structure and node values of subRoot and false otherwise.
 A subtree of a binary tree tree is a tree that consists of a node in tree and all of this node's descendants. The tree tree could also be considered as a subtree of itself.

 Example 1:
 Input: root = [3,4,5,1,2], subRoot = [4,1,2]
 Output: true

 Example 2:
 Input: root = [3,4,5,1,2,null,null,null,null,0], subRoot = [4,1,2]
 Output: false
 */

extension ViewController {
    func solve28() {
        print("Setting up Problem28 input!")
        let root = TreeNode(1)
        root.left = TreeNode(1)

        let root2 = TreeNode(1)

        let output = Solution().isSubtree(root, root2)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    func isSubtree(_ root: TreeNode?, _ subRoot: TreeNode?) -> Bool {
        guard let root = root, let subRoot = subRoot else { return false }

        let queue = Queue<TreeNode>()
        queue.enQueue(root)

        var isEqualTreeFound: Bool = false

        while queue.isEmpty == false {
            let currentNode = queue.deQueue()!

            if currentNode.val == subRoot.val && isEqualTree(currentNode, subRoot) {
                isEqualTreeFound = true
                break
            }

            if let leftNode = currentNode.left { queue.enQueue(leftNode) }
            if let rightNode = currentNode.right { queue.enQueue(rightNode) }
        }

        return isEqualTreeFound
    }

    private func isEqualTree(_ root1: TreeNode?, _ root2: TreeNode?) -> Bool {
        if root1 == nil, root2 == nil { return true }

        guard let root1 = root1, let root2 = root2 else { return false }

        let isleftEqualTree = isEqualTree(root1.left, root2.left)
        let isRightEqualTree = isEqualTree(root1.right, root2.right)

        return root1.val == root2.val && isleftEqualTree && isRightEqualTree
    }
}
