//
//  ViewController+Problem31.swift
//  BinaryTree
//
//  Created by Manish Rathi on 16/03/2022.
//

import Foundation
/*
 1302. Deepest Leaves Sum
 https://leetcode.com/problems/deepest-leaves-sum/
 Given the root of a binary tree, return the sum of values of its deepest leaves.

 Example 1:
 Input: root = [1,2,3,4,5,null,6,7,null,null,null,null,8]
 Output: 15

 Example 2:
 Input: root = [6,7,8,2,7,1,3,9,null,1,4,null,null,null,5]
 Output: 19
 */

extension ViewController {
    func solve31() {
        print("Setting up Problem31 input!")
        let root = TreeNode(1)
        root.left = TreeNode(2)
        root.right = TreeNode(3)
        root.left?.left = TreeNode(4)
        root.left?.right = TreeNode(5)
        root.right?.right = TreeNode(6)
        root.left?.left?.left = TreeNode(7)
        root.right?.right?.right = TreeNode(8)

        let output = Solution().deepestLeavesSum(root)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    private var deepestLevel = Int.min
    private var deepestLevelNodeValuesMap: [Int: [Int]] = [:]

    func deepestLeavesSum(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }

        findDeepestLeaves(root, 0)

        let deepestLevelNodeValues = deepestLevelNodeValuesMap[deepestLevel]!

        var outputSum = 0

        for deepestLevelNodeValue in deepestLevelNodeValues {
            outputSum += deepestLevelNodeValue
        }

        return outputSum
    }

    private func findDeepestLeaves(_ root: TreeNode?, _ currentLevel: Int) {
        guard let currentNode = root else { return }

        let newLevel = currentLevel + 1

        if currentNode.left == nil && currentNode.right == nil {
            deepestLevel = max(deepestLevel, newLevel)

            if let deepestLevelNodeValues = deepestLevelNodeValuesMap[newLevel] {
                deepestLevelNodeValuesMap[newLevel] = deepestLevelNodeValues + [currentNode.val]
            } else {
                deepestLevelNodeValuesMap[newLevel] = [currentNode.val]
            }
        }

        findDeepestLeaves(currentNode.left, newLevel)
        findDeepestLeaves(currentNode.right, newLevel)
    }
}
