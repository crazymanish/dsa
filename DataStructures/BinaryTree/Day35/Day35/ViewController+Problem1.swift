//
//  ViewController+Problem1.swift
//  Day35
//
//  Created by Manish Rathi on 07/03/2022.
//

import Foundation

/*
 https://leetcode.com/problems/range-sum-of-bst/
 938. Range Sum of BST

 Given the root node of a binary search tree and two integers low and high, return the sum of values of all nodes with a value in the inclusive range [low, high].

 Example 1:
 https://assets.leetcode.com/uploads/2020/11/05/bst1.jpg
        10
    /       \
    5       15
  /  \       \
 3    7       18

 Input: root = [10,5,15,3,7,null,18], low = 7, high = 15
 Output: 32
 Explanation: Nodes 7, 10, and 15 are in the range [7, 15]. 7 + 10 + 15 = 32.
 */

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?

    public init() {
        self.val = 0
        self.left = nil
        self.right = nil
    }

    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }

    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

extension ViewController {
    func solve() {
        print("Setting up input!")
        let root = TreeNode(10)
        root.left = TreeNode(5)
        root.right = TreeNode(15)
        root.left?.left = TreeNode(3)
        root.left?.right = TreeNode(7)
        root.right?.right = TreeNode(18)

        let outputSum = rangeSumBST(root, 7, 15)
        print("Output sum: \(outputSum)")
    }

    func rangeSumBST(_ root: TreeNode?, _ low: Int, _ high: Int) -> Int {
        guard let rootNode = root else { return 0 }

        var outputSum = 0

        let queue = Queue()
        queue.enQueue(rootNode)

        while queue.isEmpty == false {
            let currentNode = queue.deQueue()!

            if currentNode.val >= low && currentNode.val <= high {
                outputSum += currentNode.val
            }

            if currentNode.left != nil { queue.enQueue(currentNode.left!) }
            if currentNode.right != nil { queue.enQueue(currentNode.right!) }
        }

        return outputSum
    }
}

class Queue {
    private var array: [TreeNode] = []

    var isEmpty: Bool { return array.isEmpty }

    func enQueue(_ treeNode: TreeNode) {
        array.append(treeNode)
    }

    func deQueue() -> TreeNode? {
        if isEmpty { return nil }

        return array.removeFirst()
    }
}
