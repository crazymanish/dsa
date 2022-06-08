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
    private var hashMap: [Int: [[Int]]] = [:]

    func pathSum(_ root: TreeNode?, _ targetSum: Int) -> [[Int]] {
        guard let root = root else { return [] }

        findAllPathSum(root, targetSum, 0, [])

        return hashMap[targetSum] ?? []
    }

    private func findAllPathSum(_ root: TreeNode?, _ targetSum: Int, _ currentSum: Int, _ currentElements: [Int]) {
        guard let currentNode = root else { return }

        let newSum = currentSum + currentNode.val
        let newElements = currentElements + [currentNode.val]

        if currentNode.isLeafNode && newSum == targetSum {
            if let cacheElements = hashMap[newSum] {
                hashMap[newSum] = cacheElements + [newElements]
            } else {
                hashMap[newSum] = [newElements]
            }
        }

        findAllPathSum(currentNode.left, targetSum, newSum, newElements)
        findAllPathSum(currentNode.right, targetSum, newSum, newElements)
    }
}

private extension TreeNode {
    var isLeafNode: Bool { left == nil && right == nil }
}
