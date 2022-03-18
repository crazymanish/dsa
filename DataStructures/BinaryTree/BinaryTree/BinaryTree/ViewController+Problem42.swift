//
//  ViewController+Problem42.swift
//  BinaryTree
//
//  Created by Manish Rathi on 18/03/2022.
//

import Foundation
/*
 662. Maximum Width of Binary Tree
 https://leetcode.com/problems/maximum-width-of-binary-tree/
 Given the root of a binary tree, return the maximum width of the given tree.
 The maximum width of a tree is the maximum width among all levels.
 The width of one level is defined as the length between the end-nodes (the leftmost and rightmost non-null nodes), where the null nodes between the end-nodes that would be present in a complete binary tree extending down to that level are also counted into the length calculation.
 It is guaranteed that the answer will in the range of a 32-bit signed integer.

 Example 1:
 Input: root = [1,3,2,5,3,null,9]
 Output: 4
 Explanation: The maximum width exists in the third level with length 4 (5,3,null,9).

 Example 2:
 Input: root = [1,3,2,5,null,null,9,6,null,7]
 Output: 7
 Explanation: The maximum width exists in the fourth level with length 7 (6,null,null,null,null,null,7).
 */

extension ViewController {
    func solve42() {
        print("Setting up Problem42 input!")
        let root = TreeNode(1)
        root.left = TreeNode(3)
        root.right = TreeNode(2)
        root.left?.left = TreeNode(5)

        let output = Solution().widthOfBinaryTree(root)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    func widthOfBinaryTree(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }

        var maxWidth = Int.min
        let queue = Queue<NodeInfo>()
        queue.enQueue(NodeInfo(root, 0))

        while queue.isEmpty == false {
            var firstNodeInfoIndex: Int64 = 0
            var lastNodeInfoIndex: Int64 = 0
            let currentLevelStartingIndex = queue.front!.index
            let currentLevelNodeCount = queue.count

            for i in 0..<currentLevelNodeCount {
                let currentNodeInfo = queue.deQueue()!
                let currentNodeIndex = currentNodeInfo.index - currentLevelStartingIndex

                if i == 0 { firstNodeInfoIndex = currentNodeIndex }
                if i == currentLevelNodeCount-1 { lastNodeInfoIndex = currentNodeIndex }

                let newIndex = (currentNodeIndex*2)

                if let leftNode = currentNodeInfo.node.left {
                    queue.enQueue(NodeInfo(leftNode, newIndex))
                }

                if let rightNode = currentNodeInfo.node.right {
                    queue.enQueue(NodeInfo(rightNode, newIndex+1))
                }
            }

            let currentLevelWidth = Int(lastNodeInfoIndex - firstNodeInfoIndex + 1)
            maxWidth = max(maxWidth, currentLevelWidth)
        }

        return maxWidth
    }
}

private struct NodeInfo {
    let node: TreeNode
    let index: Int64

    init(_ node: TreeNode, _ index: Int64) {
        self.node = node
        self.index = index
    }
}
