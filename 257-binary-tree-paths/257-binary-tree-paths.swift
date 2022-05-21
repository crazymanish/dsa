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
    func binaryTreePaths(_ root: TreeNode?) -> [String] {
        guard let root = root else { return [] }
        
        var output: [String] = []

        let queue = Queue<Array<String>>()
        findAllPaths(root, queue: queue, currentPathNodes: [])

        while queue.isEmpty == false {
            let currentPathNodes = queue.deQueue()!
            let currentPath = currentPathNodes.joined(separator: "->")

            output.append(currentPath)
        }

        return output
    }
    
    private func findAllPaths(_ root: TreeNode?, queue: Queue<Array<String>>, currentPathNodes: [String]) {
        if root == nil { return }

        let newPathNodes = currentPathNodes + [String(root!.val)]

        if root?.left == nil && root?.right == nil {
            queue.enQueue(newPathNodes)
        } else {
            findAllPaths(root?.left, queue: queue, currentPathNodes: newPathNodes)
            findAllPaths(root?.right, queue: queue, currentPathNodes: newPathNodes)
        }
    }
}

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

