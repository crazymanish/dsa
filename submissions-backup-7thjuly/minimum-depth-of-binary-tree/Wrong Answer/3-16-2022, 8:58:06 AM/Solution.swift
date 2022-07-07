// https://leetcode.com/problems/minimum-depth-of-binary-tree

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
    private var minDepth = Int.max

    func minDepth(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        
        findAllPaths(root, "")

        return minDepth
    }

    private func findAllPaths(_ root: TreeNode?, _ currentPath: String) {
        guard let currentNode = root else { return }

        let newPath = currentPath + "\(currentNode.val)"

        if currentNode.left == nil && currentNode.right == nil {
            minDepth = min(minDepth, newPath.count)
        }

        findAllPaths(currentNode.left, newPath)
        findAllPaths(currentNode.right, newPath)
    }
}
