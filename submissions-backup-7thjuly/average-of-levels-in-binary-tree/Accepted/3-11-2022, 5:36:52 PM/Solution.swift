// https://leetcode.com/problems/average-of-levels-in-binary-tree

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init() { self.val = 0; self.left = nil; self.right = nil; }
 *     public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
 *     public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
 *         self.val = val
 *         self.left = left
 *         self.right = right
 *     }
 * }
 */
class Queue<T> {
    private var array: [T] = []

    var isEmpty: Bool { return array.isEmpty }

    func enQueue(_ value: T) {
        array.append(value)
    }

    func deQueue() -> T? {
        if isEmpty { return nil }

        return array.removeFirst()
    }
}


class Solution {
    func averageOfLevels(_ root: TreeNode?) -> [Double] {
        guard let rootNode = root else { return [] }

        var averageOfLevels: [Double] = []
        let queue = Queue<TreeNode>()
        queue.enQueue(rootNode)

        while queue.isEmpty == false {
            var currentLevelSum = 0
            var currentLevelNodes: [TreeNode] = []

            while queue.isEmpty == false {
                let currentNode = queue.deQueue()!
                currentLevelNodes.append(currentNode)
            }

            for node in currentLevelNodes {
                currentLevelSum += node.val

                if let left = node.left { queue.enQueue(left) }
                if let right = node.right { queue.enQueue(right) }
            }

            let currentLevelAverage = Double(currentLevelSum) / Double(currentLevelNodes.count)
            averageOfLevels.append(currentLevelAverage)
        }

        return averageOfLevels
    }
}