// https://leetcode.com/problems/find-mode-in-binary-search-tree

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
    private var nodeValueCounterMap: [Int : Int] = [:]
    private var maximumCounter: Int = Int.min

    func findMode(_ root: TreeNode?) -> [Int] {
        guard let currentNode = root else { return [] }

        findRecursiveMode(currentNode)

        var outputResults: [Int] = []

        for (key, value) in nodeValueCounterMap {
            if value == maximumCounter { outputResults.append(key) }
        }

        return outputResults
    }

    private func findRecursiveMode(_ root: TreeNode?) {
        guard let currentNode = root else { return }

        let currentNodeValue = currentNode.val
        let currentNodeCounter: Int

        if let cacheCounter = nodeValueCounterMap[currentNodeValue] {
            currentNodeCounter = cacheCounter + 1
        } else {
            currentNodeCounter = 0
        }

        nodeValueCounterMap[currentNodeValue] = currentNodeCounter

        maximumCounter = max(maximumCounter, currentNodeCounter)

        findRecursiveMode(currentNode.left)
        findRecursiveMode(currentNode.right)
    }
}
