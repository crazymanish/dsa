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
    func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else { return [] }

        var outputArray: [[Int]] = []
        var zigzagFlag = true
        let queue = Queue<TreeNode>()
        queue.enQueue(root)

        while queue.isEmpty == false {
            var currentLevelValues: [Int] = []
            let stack = Stack<Int>()
            let queueCount = queue.count

            for _ in 0..<queueCount {
                let currentNode = queue.deQueue()!

                if zigzagFlag {
                    currentLevelValues.append(currentNode.val)
                } else {
                    stack.push(currentNode.val)
                }

                if let leftNode = currentNode.left { queue.enQueue(leftNode) }
                if let rightNode = currentNode.right { queue.enQueue(rightNode) }
            }

            while stack.isEmpty == false { currentLevelValues.append(stack.pop()!) }

            outputArray.append(currentLevelValues)
            zigzagFlag.toggle()
        }

        return outputArray
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


class Queue<T> {
    private var array: [T] = []
    
    var isEmpty: Bool { array.isEmpty }
    
    var count: Int { array.count }
    
    func enQueue(_ element: T) {
        array.append(element)
    }
    
    func deQueue() -> T? {
        if isEmpty { return nil }
        
        return array.removeFirst()
    }
}