//
//  ViewController+Problem13.swift
//  BinaryTree
//
//  Created by Manish Rathi on 12/03/2022.
//

import Foundation
/*
 653. Two Sum IV - Input is a BST
 https://leetcode.com/problems/two-sum-iv-input-is-a-bst/
 Given the root of a Binary Search Tree and a target number k, return true if there exist two elements in the BST such that their sum is equal to the given target.

 Example 1:
 Input: root = [5,3,6,2,4,null,7], k = 9
 Output: true

 Example 2:
 Input: root = [5,3,6,2,4,null,7], k = 28
 Output: false
 */

extension ViewController {
    func solve13() {
        print("Setting up Problem13 input!")
        let root = TreeNode(1)
        root.right = TreeNode(2)
        root.right?.left = TreeNode(3)

        let output = Solution().findTarget(root, 4)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    private var treeNodeValuesMap: [Int : Bool] = [:]

    func findTarget(_ root: TreeNode?, _ k: Int) -> Bool {
        guard let root = root else { return false }

        let currentNodeValue = root.val
        let remainingTarget = k - currentNodeValue

        if treeNodeValuesMap[remainingTarget] != nil { return true }

        treeNodeValuesMap[currentNodeValue] = true

        let findTargetInLeft = findTarget(root.left, k)
        let findTargetInRight = findTarget(root.right, k)

        return findTargetInLeft || findTargetInRight
    }
}
