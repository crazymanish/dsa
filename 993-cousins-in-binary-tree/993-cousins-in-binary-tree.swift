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
    func isCousins(_ root: TreeNode?, _ x: Int, _ y: Int) -> Bool {
        guard let root = root else { return false }

        typealias TreeNodeLevelAndParent = (level: Int, parent: Int)
        var hashMap: [Int : TreeNodeLevelAndParent] = [:]

        let queue = Queue<TreeNode>()
        queue.enQueue(root)
        hashMap[root.val] = (level: 0, parent: 0)

        while queue.isEmpty == false {
            let currentNode = queue.deQueue()!
            let currentNodeMap = hashMap[currentNode.val]!

            if let leftNode = currentNode.left {
                queue.enQueue(leftNode)
                hashMap[leftNode.val] = (level: currentNodeMap.level + 1, parent: currentNode.val)
            }

            if let rightNode = currentNode.right {
                queue.enQueue(rightNode)
                hashMap[rightNode.val] = (level: currentNodeMap.level + 1, parent: currentNode.val)
            }
        }

        let xNodeHashMap = hashMap[x]!
        let yNodeHashMap = hashMap[y]!

        return xNodeHashMap.level == yNodeHashMap.level && xNodeHashMap.parent != yNodeHashMap.parent
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
