// https://leetcode.com/problems/lowest-common-ancestor-of-deepest-leaves

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
    private var depthWithLcaNodeHashMap: [Int : TreeNode] = [:]
    private var maxDepth = Int.min

    func lcaDeepestLeaves(_ root: TreeNode?) -> TreeNode? {
        guard let root = root else { return nil }

        findLcaDeepestLeaves(root, 0, root)

        return depthWithLcaNodeHashMap[maxDepth]
    }

    private func findLcaDeepestLeaves(_ root: TreeNode?, _ currentDepth: Int, _ currentPathLcaNode: TreeNode) {
        guard let currentNode = root else { return }

        let newDepth = currentDepth + 1
        maxDepth = max(maxDepth, newDepth)

        var newPathLcaNode = currentPathLcaNode
        if currentNode.val < currentPathLcaNode.val { newPathLcaNode = currentNode }

        if let existingLcaNode = depthWithLcaNodeHashMap[newDepth] {
            let minLcaNode = TreeNode.minNode(existingLcaNode, node2: newPathLcaNode)
            depthWithLcaNodeHashMap[newDepth] = minLcaNode
        } else {
            depthWithLcaNodeHashMap[newDepth] = newPathLcaNode
        }

        findLcaDeepestLeaves(currentNode.left, newDepth, newPathLcaNode)
        findLcaDeepestLeaves(currentNode.right, newDepth, newPathLcaNode)
    }
}

private extension TreeNode {
    static func minNode(_ node1: TreeNode, node2: TreeNode) -> TreeNode {
        if node1.val < node2.val { return node1 }

        return node2
    }
}