//
//  ViewController+Problem1.swift
//  BinaryTree
//
//  Created by Manish Rathi on 08/03/2022.
//

import Foundation
/*
 897. Increasing Order Search Tree
 https://leetcode.com/problems/increasing-order-search-tree/

 Given the root of a binary search tree, rearrange the tree in in-order so that the leftmost node in the tree is now the root of the tree, and every node has no left child and only one right child.
 */

class Queue {
    private var array: [Int] = []

    var isEmpty: Bool { return array.isEmpty }

    func enQueue(_ value: Int) {
        array.append(value)
    }

    func deQueue() -> Int? {
        if isEmpty { return nil }

        return array.removeFirst()
    }
}

extension ViewController {
    func solve1() {
        print("Setting up Problem1 input!")
        let root = TreeNode(5)
        root.left = TreeNode(1)
        root.right = TreeNode(7)

        let output = increasingBST(root)
        print("Output: \(output)")
    }

    func increasingBST(_ root: TreeNode?) -> TreeNode? {
        if root == nil { return nil }

        let queue = Queue()
        getAllBSTNodes(root, queue: queue)

        var outputNode: TreeNode? = TreeNode(-1)
        let outputRootNode = outputNode

        while queue.isEmpty == false {
            let newNode = TreeNode(queue.deQueue()!)
            outputNode?.right = newNode
            outputNode = outputNode?.right
        }

        return outputRootNode?.right
    }

    func getAllBSTNodes(_ root: TreeNode?, queue: Queue) {
        if root == nil { return }

        getAllBSTNodes(root?.left, queue: queue)
        queue.enQueue(root!.val)
        getAllBSTNodes(root?.right, queue: queue)
    }
}
