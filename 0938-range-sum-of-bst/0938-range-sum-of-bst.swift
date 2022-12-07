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
class Solution {
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