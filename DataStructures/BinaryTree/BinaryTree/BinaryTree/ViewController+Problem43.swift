//
//  ViewController+Problem43.swift
//  BinaryTree
//
//  Created by Manish Rathi on 18/03/2022.
//

import Foundation
/*
 894. All Possible Full Binary Trees
 https://leetcode.com/problems/all-possible-full-binary-trees/
 Given an integer n, return a list of all possible full binary trees with n nodes. Each node of each tree in the answer must have Node.val == 0.
 Each element of the answer is the root node of one possible tree. You may return the final list of trees in any order.
 A full binary tree is a binary tree where each node has exactly 0 or 2 children.

 Example 1:
 Input: n = 7
 Output: [[0,0,0,null,null,0,0,null,null,0,0],[0,0,0,null,null,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,null,null,null,null,0,0],[0,0,0,0,0,null,null,0,0]]

 Example 2:
 Input: n = 3
 Output: [[0,0,0]]
 */

extension ViewController {
    func solve43() {
        print("Setting up Problem43 input!")

        let output = Solution().allPossibleFBT(7)
        print("Output: \(output.count)")
    }
}

fileprivate class Solution {
    private var hashMap: [Int: [TreeNode]] = [:]

    func allPossibleFBT(_ n: Int) -> [TreeNode?] {
        if n == 0 { return [] }
        if n == 1 { return [TreeNode(0)] }
        if let cacheFBT = hashMap[n] { return cacheFBT }

        var result: [TreeNode] = []

        for possibleLeftNode in 1..<n {
            let possibleRightNode = n - possibleLeftNode - 1

            let leftPossibleFBTs = allPossibleFBT(possibleLeftNode)
            let rightPossibleFBTs = allPossibleFBT(possibleRightNode)

            for leftPossibleFBT in leftPossibleFBTs {
                for rightPossibleFBT in rightPossibleFBTs {
                    result.append(TreeNode(0, leftPossibleFBT, rightPossibleFBT))
                }
            }

            hashMap[n] = result
        }

        return result
    }
}
