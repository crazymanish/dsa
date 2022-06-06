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
    func levelOrderBottom(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else { return [] }

        var levelOrderValues: [[Int]] = []
        let stack = Stack<[Int]>()
        let queue = Queue<TreeNode>()
        queue.enQueue(root)

        while queue.isEmpty == false {
            let queueCount = queue.count
            var currentLevelValues: [Int] = []

            for _ in 0..<queueCount {
                let currentNode = queue.deQueue()!

                currentLevelValues.append(currentNode.val)

                if let leftNode = currentNode.left { queue.enQueue(leftNode) }
                if let rightNode = currentNode.right { queue.enQueue(rightNode) }
            }

            stack.push(currentLevelValues)
        }

        while stack.isEmpty == false {
            levelOrderValues.append(stack.pop()!)
        }

        return levelOrderValues
    }
}

class Queue<T> {
    private var array: [T] = []

    var isEmpty: Bool { return array.isEmpty }

    var count: Int { return array.count }

    func enQueue(_ value: T) {
        array.append(value)
    }

    func deQueue() -> T? {
        if isEmpty { return nil }

        return array.removeFirst()
    }
}

class Stack<T> {
    private var array: [T] = []

    var isEmpty: Bool { return array.isEmpty }

    func push(_ value: T) {
        array.append(value)
    }

    func pop() -> T? {
        if isEmpty { return nil }

        return array.removeLast()
    }
}
