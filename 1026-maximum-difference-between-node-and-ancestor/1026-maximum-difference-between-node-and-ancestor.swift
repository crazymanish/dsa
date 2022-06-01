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
    private var maxAncestorDifference = Int.min

    func maxAncestorDiff(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }

        findMaxAncestorDiff(root, root.val, root.val)

        return maxAncestorDifference
    }

    private func findMaxAncestorDiff(_ root: TreeNode?, _ currentPathMinValueNode: Int, _ currentPathMaxValueNode: Int) {
        guard let currentNode = root else { return }

        let newMinValueNode = min(abs(currentNode.val), abs(currentPathMinValueNode))
        let newMaxValueNode = max(abs(currentNode.val), abs(currentPathMaxValueNode))

        if currentNode.isLeafNode {
            let currentPathAncestorDifference = abs(newMaxValueNode - newMinValueNode)
            maxAncestorDifference = max(currentPathAncestorDifference, maxAncestorDifference)
        }

        findMaxAncestorDiff(currentNode.left, newMinValueNode, newMaxValueNode)
        findMaxAncestorDiff(currentNode.right, newMinValueNode, newMaxValueNode)
    }
}

private extension TreeNode {
    var isLeafNode: Bool { left == nil && right == nil }
}