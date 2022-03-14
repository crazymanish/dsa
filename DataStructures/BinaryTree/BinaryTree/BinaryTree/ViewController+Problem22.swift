//
//  ViewController+Problem22.swift
//  BinaryTree
//
//  Created by Manish Rathi on 14/03/2022.
//

import Foundation
/*
 993. Cousins in Binary Tree
 https://leetcode.com/problems/cousins-in-binary-tree/
 Given the root of a binary tree with unique values and the values of two different nodes of the tree x and y, return true if the nodes corresponding to the values x and y in the tree are cousins, or false otherwise.
 Two nodes of a binary tree are cousins if they have the same depth with different parents.
 Note that in a binary tree, the root node is at the depth 0, and children of each depth k node are at the depth k + 1.

 Example 1:
 Input: root = [1,2,3,4], x = 4, y = 3
 Output: false

 Example 2:
 Input: root = [1,2,3,null,4,null,5], x = 5, y = 4
 Output: true

 Example 3:
 Input: root = [1,2,3,null,4], x = 2, y = 3
 Output: false
 */

extension ViewController {
    func solve22() {
        print("Setting up Problem22 input!")
        let root = TreeNode(1)
        root.left = TreeNode(2)
        root.right = TreeNode(3)
        root.left?.right = TreeNode(4)
        // root.right?.right = TreeNode(5)

        let output = Solution().isCousins(root, 2, 3)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    func isCousins(_ root: TreeNode?, _ x: Int, _ y: Int) -> Bool {
        guard let root = root else { return false }

        typealias TreeNodeLevelAndParent = (level: Int, parent: Int)
        var hashMap: [Int : TreeNodeLevelAndParent] = [:]

        let queue = Queue<TreeNode>()
        queue.enQueue(root)
        hashMap[root.val] = (level: 0, parent: 0)

        while queue.isEmpty == false {
            let currentNode = queue.deQueue()!
            let currentNodeMap = hashMap[currentNode.val]!

            if let leftNode = currentNode.left {
                queue.enQueue(leftNode)
                hashMap[leftNode.val] = (level: currentNodeMap.level + 1, parent: currentNode.val)
            }

            if let rightNode = currentNode.right {
                queue.enQueue(rightNode)
                hashMap[rightNode.val] = (level: currentNodeMap.level + 1, parent: currentNode.val)
            }
        }

        let xNodeHashMap = hashMap[x]!
        let yNodeHashMap = hashMap[y]!

        return xNodeHashMap.level == yNodeHashMap.level && xNodeHashMap.parent != yNodeHashMap.parent
    }
}
