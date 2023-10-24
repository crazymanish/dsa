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
    func largestValues(_ root: TreeNode?) -> [Int] {
        guard let root = root else { return [] }

        var largestValues: [Int] = []
        let queue = Queue()
        queue.enQueue(root)

        while queue.isEmpty == false {
            let queueCount = queue.count
            var currentLevelLargestValue = Int.min
            
            for _ in 0..<queueCount {
                let currentNode = queue.deQueue()!

                currentLevelLargestValue = max(currentLevelLargestValue, currentNode.val)

                if let leftNode = currentNode.left { queue.enQueue(leftNode) }
                if let rightNode = currentNode.right { queue.enQueue(rightNode) }
            }
            
            largestValues.append(currentLevelLargestValue)
        }

        return largestValues
    }
}

class Queue {
    private var array: [TreeNode] = []

    var isEmpty: Bool { return array.isEmpty }

    var count: Int { return array.count }

    func enQueue(_ value: TreeNode) {
        array.append(value)
    }

    func deQueue() -> TreeNode? {
        if isEmpty { return nil }

        return array.removeFirst()
    }
}