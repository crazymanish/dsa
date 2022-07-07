// https://leetcode.com/problems/path-sum

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
    private var pathSumMap: [Int: Bool] = [:]

    func hasPathSum(_ root: TreeNode?, _ targetSum: Int) -> Bool {
        findAllPaths(root, 0)

        return pathSumMap[targetSum] != nil
    }

    private func findAllPaths(_ root: TreeNode?, _ currentSum: Int) {
        guard let currentNode = root else { return }

        let newSum = currentSum + currentNode.val

        if currentNode.left == nil && currentNode.right == nil {
            pathSumMap[newSum] = true
        }

        findAllPaths(currentNode.left, newSum)
        findAllPaths(currentNode.right, newSum)
    }
}