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
    private var secondMinimumValue = Int.max

    func findSecondMinimumValue(_ root: TreeNode?) -> Int {
        guard let root = root else { return -1 }
        
        findMinimumValue(root.left, root.val)
        findMinimumValue(root.right, root.val)

        if secondMinimumValue == Int.max { return -1 } // No second minimum value found

        return secondMinimumValue
    }

    private func findMinimumValue(_ root: TreeNode?, _ firstMinimumValue: Int) {
        guard let currentNode = root else { return }

        if currentNode.val > firstMinimumValue {
            secondMinimumValue = min(secondMinimumValue, currentNode.val)   
        }

        findMinimumValue(currentNode.left, firstMinimumValue)
        findMinimumValue(currentNode.right, firstMinimumValue)
    }
}