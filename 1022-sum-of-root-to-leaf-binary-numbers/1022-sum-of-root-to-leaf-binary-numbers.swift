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
        func sumRootToLeaf(_ root: TreeNode?) -> Int {
        if root == nil { return 0 }

        var output = 0

        let queue = Queue<String>()
        findAllPaths(root, queue: queue, currentPath: "")

        while queue.isEmpty == false {
            if let currentSum = Int(queue.deQueue()!, radix: 2) {
                output += currentSum
            }
        }

        return output
    }

    func findAllPaths(_ root: TreeNode?, queue: Queue<String>, currentPath: String) {
        if root == nil { return }

        let newPath = currentPath + String(root!.val)

        if root?.left == nil && root?.right == nil {
            queue.enQueue(newPath)
        } else {
            findAllPaths(root?.left, queue: queue, currentPath: newPath)
            findAllPaths(root?.right, queue: queue, currentPath: newPath)
        }
    }
}