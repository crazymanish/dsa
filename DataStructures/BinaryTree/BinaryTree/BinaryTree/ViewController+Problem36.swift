//
//  ViewController+Problem36.swift
//  BinaryTree
//
//  Created by Manish Rathi on 17/03/2022.
//

import Foundation
/*
 1305. All Elements in Two Binary Search Trees
 https://leetcode.com/problems/all-elements-in-two-binary-search-trees/
 Given two binary search trees root1 and root2, return a list containing all the integers from both trees sorted in ascending order.

 Example 1:
 Input: root1 = [2,1,4], root2 = [1,0,3]
 Output: [0,1,1,2,3,4]

 Example 2:
 Input: root1 = [1,null,8], root2 = [8,1]
 Output: [1,1,8,8]
 */

extension ViewController {
    func solve36() {
        print("Setting up Problem36 input!")
        let root1 = TreeNode(2)
        root1.left = TreeNode(1)
        root1.right = TreeNode(4)

        let root2 = TreeNode(1)
        root2.left = TreeNode(0)
        root2.right = TreeNode(3)

        let output = Solution().getAllElements(root1, root2)
        print("Output: \(output)")
    }
}

fileprivate class Solution {
    func getAllElements(_ root1: TreeNode?, _ root2: TreeNode?) -> [Int] {
        let root1Elements = inorderTraversal(root1)
        let root2Elements = inorderTraversal(root2)

        return mergeElementsInAscendingOrder(root1Elements, root2Elements)
    }

    private func inorderTraversal(_ root: TreeNode?) -> [Int] {
        guard let currentNode = root else { return [] }

        let leftInorder = inorderTraversal(currentNode.left)
        let rightInorder = inorderTraversal(currentNode.right)

        return leftInorder + [currentNode.val] + rightInorder
    }

    private func mergeElementsInAscendingOrder(_ array1: [Int], _ array2: [Int]) -> [Int] {
        var inputArray1 = array1
        var inputArray2 = array2
        var outputArray: [Int] = []

        while inputArray1.isEmpty == false || inputArray2.isEmpty == false {
            let minElement: Int

            if inputArray1.isEmpty {
                minElement = inputArray2.removeFirst()
            } else if inputArray2.isEmpty {
                minElement = inputArray1.removeFirst()
            } else {
                let array1FirstElement = inputArray1.first ?? Int.max
                let array2FirstElement = inputArray2.first ?? Int.max

                if array1FirstElement < array2FirstElement {
                    minElement = inputArray1.removeFirst()
                } else {
                    minElement = inputArray2.removeFirst()
                }
            }

            outputArray.append(minElement)
        }

        return outputArray
    }
}
